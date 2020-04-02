const std = @import("std");
const assert = std.debug.assert;

var numbers_left: u32 = undefined;

fn eventuallyNullSequence() ?u32 {
    return if (numbers_left == 0) null else blk: {
        numbers_left -= 1;
        break :blk numbers_left;
    };
}

test "while with optionals" {
    var sum1: u32 = 0;
    numbers_left = 3;

    while (eventuallyNullSequence()) |e| {
        sum1 += e;
    }
    assert(sum1 == 3);

    var sum2: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |e| {
        sum2 += e;
    } else {
        assert(sum2 == 3);
    }
}
