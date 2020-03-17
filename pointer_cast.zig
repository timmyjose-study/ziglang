const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "pointer casting" {
    const bytes align(@alignOf(u32)) = [_]u8{ 0x12, 0x12, 0x12, 0x12 };
    const u32_ptr = @ptrCast(*const u32, &bytes);
    assert(u32_ptr.* == 0x12121212);
    warn("{x}, {b}\n", .{ u32_ptr.*, u32_ptr.* });

    const u32_value = std.mem.bytesAsSlice(u32, bytes[0..])[0];
    assert(u32_value == 0x12121212);
    warn("{x}, {b}\n", .{ u32_value, u32_value });

    const another_u32_value = @bitCast(u32, bytes);
    assert(another_u32_value == 0x12121212);

    const i32_ptr = @ptrCast(*const i32, &bytes);
    assert(i32_ptr.* == 0x12121212);
}

test "pointer Child field" {
    assert((*i32).Child == i32);
    assert((*u32).Child == u32);
    assert((*i8).Child == i8);
    assert((*i676).Child == i676);
    assert((*u8).Child == u8);
}
