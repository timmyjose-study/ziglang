const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const warn = std.debug.warn;

test "basic memory allocator usage" {
    var buffer: [100]u8 = undefined;
    const allocator = &std.heap.FixedBufferAllocator.init(&buffer).allocator;
    const result = try concat(allocator, "hello", "world");
    assert(std.mem.eql(u8, result, "helloworld"));
    warn("result = {}\n", .{result});
}

fn concat(allocator: *Allocator, a: []const u8, b: []const u8) ![]u8 {
    const result = try allocator.alloc(u8, a.len + b.len);
    std.mem.copy(u8, result, a);
    std.mem.copy(u8, result[a.len..], b);
    return result;
}

test "arena allocator" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = &arena.allocator;

    var counter: usize = 0;
    while (counter < 10) : (counter += 1) {
        const ptr = try allocator.create(i32);
        ptr.* = @intCast(i32, counter);
        assert(ptr.* == counter);
    }
}
