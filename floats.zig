const std = @import("std");
const warn = std.debug.warn;

test "float literals" {
    const float = 1.23e+100;
    warn("float = {}\n", .{@floatCast(f128, float)});

    const another_float = 0x102.10p-10;
    warn("another_float = {}\n", .{@floatCast(f128, another_float)});
}

test "special float constants" {
    const inf = std.math.inf(f32);
    warn("inf = {}\n", .{@floatCast(f32, inf)});

    const neg_inf = -std.math.inf(f32);
    warn("neg_inf = {}\n", .{@floatCast(f32, neg_inf)});

    const nan = std.math.nan(f64);
    warn("nan = {}\n", .{@floatCast(f64, nan)});
}
