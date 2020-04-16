const std = @import("std");
const assert = std.debug.assert;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = &arena.allocator;
    const ptr = try allocator.create(i32);
    ptr.* = 100;
    assert(ptr.* == 100);
    std.debug.warn("ptr = {}\n", .{ptr.*});
}
