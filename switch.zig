const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "switch simple" {
    const a: u64 = 10;
    const zz: u64 = 103;

    const b = switch (a) {
        1, 2, 3 => 0,
        5...10 => 1,
        101 => blk: {
            const c: u64 = 5;
            break :blk c * 2 + 1;
        },
        zz => zz,
        // this works so long as everything is comptime known
        comptime blk: {
            const d: u32 = 5;
            const e: u32 = 100;
            break :blk d + e;
        } => 107,
        else => 9,
    };

    assert(b == 1);
}

const os_msg = switch (std.Target.current.os.tag) {
    .macosx => "we got macOS",
    else => "not macOS",
};

test "switch in global scope" {
    assert(std.mem.eql(u8, os_msg, "we got macOS"));
}

test "switch inside function" {
    const os = switch (std.Target.current.os.tag) {
        .macosx => "macOS",
        .linux => "Linux",
        .windows => "Windows",
        else => "something other OS",
    };

    warn("Current OS = {}\n", .{os});
}

test "switch on a tagged union" {
    const Point = struct {
        x: u8,
        y: u8,
    };

    const Item = union(enum) {
        A: u32,
        C: Point,
        D,
        E: u32,
    };

    var a = Item{ .C = Point{ .x = 100, .y = 200 } };
    warn("TagType of a = {}\n", .{@typeName(@TagType(Item))});

    const b = switch (a) {
        Item.A, Item.E => |item| item,
        Item.C => |*pt| blk: {
            pt.*.x += 1;
            pt.*.y -= 1;
            break :blk 99;
        },
        Item.D => 8,
    };

    assert(b == 99);
    assert(a.C.x == 101);
    assert(a.C.y == 199);
}
