const std = @import("std");
const warn = std.debug.warn;

pub fn main() void {
    warn("Hola, {}\n", .{"mundo!"});
}
