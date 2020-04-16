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

test "Thread-safe allocator example" {
    var buffer: [1000]u8 = undefined;
    const allocator = &std.heap.ThreadSafeFixedBufferAllocator.init(&buffer).allocator;
    const result = try concat(allocator, "hello", "world");
    assert(std.mem.eql(u8, result, "helloworld"));
    warn("{}\n", .{result});
}
