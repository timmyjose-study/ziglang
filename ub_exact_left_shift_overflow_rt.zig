const std = @import("std");

pub fn main() void {
    var b = @as(u8, 0b01010101);
    var x = @shlExact(b, 2);

    std.debug.warn("{}\n", .{x});
}
