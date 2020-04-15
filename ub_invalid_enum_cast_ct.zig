const Foo = enum(u32) {
    A,
    B,
    C,
};

comptime {
    const i: u32 = 100;
    const e = @intToEnum(Foo, i);
}
