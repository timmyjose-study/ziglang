pub fn main() void {
    var x: anyerror!i32 = error.WhizzBangError;
    const value = x catch unreachable;
}
