const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const warn = std.debug.warn;

fn concat(allocator: *Allocator, a: []const u8, b: []const u8) ![]u8 {
    const result = try allocator.alloc(u8, a.len + b.len);
    std.mem.copy(u8, result, a);
    std.mem.copy(u8, result[a.len..], b);
    return result;
}

test "C allocator demo" {
    const allocator = std.heap.c_allocator;
    const result = try concat(allocator, "hello", "world");
    defer {
        warn("freeing memory...\n", .{});
        allocator.free(result);
    }
    assert(std.mem.eql(u8, result, "helloworld"));
    warn("{}\n", .{result});
}
