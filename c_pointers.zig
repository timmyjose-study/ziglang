const std = @import("std");
const warn = std.debug.warn;

test "C pointers" {
    var x: c_int = 100;
    var ptr_x: [*c]c_int = &x;

    warn("ptr_x = {}\n", .{ptr_x.*});
}
