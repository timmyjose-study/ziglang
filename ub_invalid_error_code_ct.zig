comptime {
    const err = error.WhizzBangError;
    const int = @errorToInt(err) + 100;
    const anotherErr = @intToError(int);
}
