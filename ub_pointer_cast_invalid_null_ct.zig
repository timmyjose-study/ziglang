comptime {
    const opt_ptr: ?*i32 = null;
    const ptr = @ptrCast(*i32, opt_ptr);
}
