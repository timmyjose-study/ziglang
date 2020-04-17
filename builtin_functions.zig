const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "@addWithOverflow" {
    var result: u8 = 0;

    if (@addWithOverflow(u8, 255, 1, &result)) {
        warn("overflow occurred\n", .{});
    } else {
        assert(result == 256);
    }

    if (@addWithOverflow(u8, 99, 1, &result)) {
        warn("overflow occurred\n", .{});
    } else {
        assert(result == 100);
    }
}

test "@alignOf" {
    comptime {
        assert(*u32 == *align(@alignOf(u32)) u32);
    }
}

test "@as" {
    const x = 100;
    assert(@as(u8, x) == 100);
}

test "@asyncCall - perform an async call on a function pointer" {
    var data: i32 = 1;
    const Foo = struct {
        bar: async fn (*i32) void,
    };
    var foo = Foo{ .bar = func };
    var bytes: [64]u8 align(@alignOf(@Frame(func))) = undefined;
    const f = @asyncCall(&bytes, {}, foo.bar, &data);
    assert(data == 2);
    resume f;
    assert(data == 4);
}

async fn func(x: *i32) void {
    defer x.* += 2;
    x.* += 1;
    suspend;
}

test "@call - call a function" {
    assert(@call(.{}, add, .{ 10, 20 }) == 30);

    @call(.{}, helloWorld, .{});
}

fn add(x: i32, y: i32) i32 {
    return x + y;
}

fn helloWorld() void {
    warn("Hello, world!\n", .{});
}

test "@embedFile" {
    const file_contents = @embedFile("builtin_functions.zig");
    warn("file_contents = {}\n", .{file_contents});
}

test "@hasDecl" {
    // this is only for declarations, and not for fields
    const Foo = struct {
        nope: i32,
        pub var blah = "xxx";
        const hi = 1;
    };

    assert(@hasDecl(Foo, "blah"));
    assert(@hasDecl(Foo, "hi"));
    assert(!@hasDecl(Foo, "nope"));
}

test "@hasField" {
    const Foo = struct {
        nope: i32,
        pub var blah = "xx";
        const hi = 1;
    };

    assert(@hasField(Foo, "nope"));
    assert(!@hasField(Foo, "blah"));
    assert(!@hasField(Foo, "hi"));
}

test "@splat - produce a vector of the given size" {
    const scalar: i32 = 5;
    const result = @splat(5, scalar);
    assert(@TypeOf(result) == @Vector(5, i32));
    assert(std.mem.eql(i32, &@as([5]i32, result), &[_]i32{ 5, 5, 5, 5, 5 }));

    for (@as([5]i32, result)) |e| {
        warn("{} ", .{e});
    }
    warn("\n", .{});
}

test "@This - the current context" {
    var items = [_]i32{ 1, 2, 3, 4, 5 };
    const list = List(i32){ .items = items[0..] };
    assert(@TypeOf(list) == List(i32));
    assert(list.length() == items.len);
}

fn List(comptime T: type) type {
    return struct {
        const Self = @This();

        items: []T,

        fn length(self: Self) usize {
            return self.items.len;
        }
    };
}
