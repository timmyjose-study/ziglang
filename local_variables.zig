const std = @import("std");
const assert = std.debug.assert;

test "comptime vars" {
    var x: i32 = 1;
    comptime var y: i32 = 1;
    const z: i32 = 100;

    x += 1;
    y += 1;

    assert(x == 2);
    assert(y == 2);

    comptime assert(y == 2);
    comptime assert(z == 100);
}
