test "undefined behaviour - casting negative number to unsigned integer" {
    comptime {
        var x: i32 = -100;
        const unsigned = @intCast(u32, x);
    }
}
