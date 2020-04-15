pub fn main() void {
    var ptr = @intToPtr(*align(1) i32, 0x1);
    var aligned = @alignCast(4, ptr);
}
