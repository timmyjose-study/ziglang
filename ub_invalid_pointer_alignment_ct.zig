comptime {
    const ptr = @intToPtr(*align(1) i32, 0x1);
    const aligned = @alignCast(4, ptr);
}
