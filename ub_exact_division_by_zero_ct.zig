comptime {
    var a: u32 = 10;
    var b: u32 = 3;
    var c: u32 = @divExact(a, b);
}
