const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// array literal
const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

test "get the size of an array at comptime" {
    comptime {
        assert(message.len == 5);
    }
}

// a string literal is a single-item pointer to a 0-terminated character array
const same_message = "hello";

test "string literal size at comptime" {
    comptime {
        assert(same_message.len == 5);
    }
}

test "equality of string literals and single-item pointer to character array" {
    comptime {
        assert(std.mem.eql(u8, &message, same_message));
    }
}

test "iterate over an array" {
    // the type of a character literal is comptime_int
    assert(@TypeOf('x') == comptime_int);

    var sum: i32 = 0;
    for (message) |c| {
        sum += @as(i32, c);
    }

    assert(sum == 'h' + 'e' + 'l' + 'l' + 'o');
    assert(sum == 'h' + 'e' + 'l' * 2 + 'o');
}

test "modifiable array" {
    var numbers: [10]i32 = undefined;

    for (numbers) |*e, idx| {
        e.* = @intCast(i32, idx) * 10;
    }

    warn("{}\n", .{numbers});

    for (numbers) |e| {
        warn("{} ", .{e});
    }

    warn("\n", .{});
}

test "comptime array concatenation" {
    const arr1 = [_]u32{ 1, 2, 3 };
    const arr2 = [_]u32{ 4, 5, 6 };
    const arr3 = arr1 ++ arr2;

    assert(std.mem.eql(u32, &arr3, &[_]u32{ 1, 2, 3, 4, 5, 6 }));

    const hello = "hello";
    const world = "world";
    const helloworld = hello ++ world;

    assert(std.mem.eql(u8, helloworld, "helloworld"));
}

test "repeating patterns" {
    const pattern = "ab" ** 5;

    comptime {
        assert(std.mem.eql(u8, pattern, "ababababab"));
    }
}

test "fast initialisation of array" {
    const zero_array = [_]i32{0} ** 10;
    assert(zero_array.len == 10);

    for (zero_array) |e| {
        assert(e == 0);
    }

    const one_array = [_]i32{1} ** 20;
    assert(one_array.len == 20);

    for (one_array) |e| {
        assert(e == 1);
    }
}

var fancy_array = init: {
    var initial_value: [10]Point = undefined;

    for (initial_value) |*pt, idx| {
        pt.* = Point{
            .x = @intCast(i32, idx),
            .y = @intCast(i32, idx) * 2,
        };
    }

    break :init initial_value;
};

const Point = struct {
    x: i32,
    y: i32,
};

test "compile-time code to initialise an array" {
    assert(fancy_array[0].x == 0);
    assert(fancy_array[0].y == 0);
    assert(fancy_array[1].x == 1);
    assert(fancy_array[1].y == 2);
}

fn makePoint(x: i32) Point {
    return Point{
        .x = x,
        .y = x * 2,
    };
}

var more_points = [_]Point{makePoint(3)} ** 10;

test "call a function to initialise an array" {
    assert(more_points[0].x == 3);
    assert(more_points[0].y == 6);
}
