pub fn main() void {
    var opt_ptr: ?*i32 = null;
    var ptr = @ptrCast(*i32, opt_ptr);
}
