const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// the basic use of volatile in Zig is to ensure that loads and stores happen in the same order
// as that specified in the source code.
test "volatile" {
    const ptr = @intToPtr(*volatile u8, 0x12345678);
    assert(@TypeOf(ptr) == *volatile u8);
}
