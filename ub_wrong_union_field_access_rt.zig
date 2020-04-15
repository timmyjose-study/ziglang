const Foo = union {
    float: f32,
    int: i32,
};

pub fn main() void {
    var f = Foo{ .int = 12345 };
    _ = f.float;
}
