const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

test "blocks" {
    const x = 100;

    {
        const y = 200;
        warn("y in the inner block = {}\n", .{y});
    }

    warn("x in the outer scope = {}\n", .{x});
}

test "labelled block for returning values" {
    const res = blk: {
        const x = 100;
        const y = 200;

        break :blk x + y;
    };

    assert(res == 300);
}