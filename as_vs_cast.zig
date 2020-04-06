const std = @import("std");
const assert = std.debug.assert;

test "casting vs as" {
    const val: i32 = 100;

    const usize_val = @as(usize, val);
    assert(@TypeOf(usize_val) == usize);
    assert(@TypeOf(val) == i32);

    const usize_val2 = @intCast(usize, val);
    assert(@TypeOf(usize_val2) == usize);
    assert(@TypeOf(val) == i32);

    const byte_val = @as(u8, val);
    assert(@TypeOf(byte_val) == @TypeOf(@intCast(u8, byte_val)));
}
