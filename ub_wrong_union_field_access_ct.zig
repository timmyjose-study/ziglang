const Foo = union {
    float: f32,
    int: i32,
};

comptime {
    var f = Foo{ .float = 100.245 };
    _ = f.int;
}
