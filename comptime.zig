const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

fn getTheBiggerInt(x: i32, y: i32) i32 {
    return max(i32, x, y);
}

fn getTheBiggerFloat(x: f32, y: f32) f32 {
    return max(f32, x, y);
}

test "comptime" {
    assert(getTheBiggerInt(10, 12) == 12);
    assert(getTheBiggerFloat(1.2, -2.3) == 1.2);
}
