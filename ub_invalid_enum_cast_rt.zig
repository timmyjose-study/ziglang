const Foo = enum(u32) {
    A,
    B,
    C,
};

pub fn main() void {
    var i: u32 = 100;
    var e = @intToEnum(Foo, i);
}
