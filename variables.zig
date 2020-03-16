const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

var y: i32 = add(10, x); // runtime known
const x: i32 = add(12, 34); // comptime known

fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "global variables" {
    assert(x == 46);
    assert(y == 56);
}
