pub fn main() void {
    _ = foo("hello");
}

fn foo(slice: []const u8) u8 {
    return slice[5];
}
