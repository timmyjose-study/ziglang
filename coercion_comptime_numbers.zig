const std = @import("std");
const assert = std.debug.assert;

test "coercing a comptime known number from a larger to a smaller type" {
    const x: u128 = 255;
    const y: u8 = x;
    assert(x == 255);
}
