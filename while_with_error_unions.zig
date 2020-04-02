const std = @import("std");
const assert = std.debug.assert;

var numbers_left: u32 = undefined;

fn eventuallyErrorSequence() anyerror!u32 {
    return if (numbers_left == 0) error.ReachedZero else blk: {
        numbers_left -= 1;
        break :blk numbers_left;
    };
}

test "while with error unions" {
    numbers_left = 3;
    var sum1: u32 = 0;
    while (eventuallyErrorSequence()) |e| {
        sum1 += e;
    } else |_| {}

    assert(sum1 == 3);

    numbers_left = 3;
    var sum2: u32 = 0;
    while (eventuallyErrorSequence()) |e| {
        sum2 += e;
    } else |err| {
        assert(err == error.ReachedZero);
        assert(sum2 == 3);
    }
}
