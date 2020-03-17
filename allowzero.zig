const std = @import("std");
const assert = std.debug.assert;

test "allowzero" {
    var x: usize = 0;
    var ptr = @intToPtr(*allowzero i32, x);
    assert(@ptrToInt(ptr) == 0);
}
