const std = @import("std");
const warn = std.debug.warn;

pub fn main() !void {
    var byte: u8 = 255;

    byte = if (std.math.add(u8, byte, 1)) |r| r else |err| {
        warn("error while trying to add 1 to byte: {}\n", .{@errorName(err)});
        return err;
    };

    warn("result = {}\n", .{byte});
}
