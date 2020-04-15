pub fn main() void {
    var err = error.WhizzBangError;
    var int = @errorToInt(err) + 100;
    var anotherErr = @intToError(int);
}
