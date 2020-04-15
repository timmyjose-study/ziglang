const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    var x = @as(u8, 0b10101010);
    var y = @shrExact(x, 2);
    warn("{}\n", .{y});
}
