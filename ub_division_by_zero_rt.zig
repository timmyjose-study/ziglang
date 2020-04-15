const std = @import("std");

pub fn main() void {
    var a: i32 = 1;
    var b: i32 = 0;
    var c: i32 = @divTrunc(a, b);
}
