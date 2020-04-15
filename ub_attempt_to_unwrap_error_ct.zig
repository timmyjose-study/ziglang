comptime {
    const x: anyerror!i32 = error.WhizzBangError;
    const value = x catch unreachable;
}
