const std = @import("std");
const warn = std.debug.warn;

extern fn foo_strict(x: f64) f64;
extern fn foo_optimized(x: f64) f64;

test "strict vs optimized" {
    const x = 0.001;
    warn("strict = {}\n", .{foo_strict(x)});
    warn("optimized = {}\n", .{foo_optimized(x)});
}
