const std = @import("std");

pub fn main() void {
    var x: *i32 = undefined;

    std.debug.warn("{}\n", .{x.*});
}
