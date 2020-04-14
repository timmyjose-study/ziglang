const std = @import("std");
const warn = std.debug.warn;

test "aliasing vs defer" {
    const ptr = foo();
    warn("ptr = {}\n", .{ptr.?.*});
}

fn foo() ?*i32 {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    const ptr = allocator.create(i32);

    if (ptr) |p| {
        p.* = 100;
        bar(p);

        return p;
    } else |err| {
        return null;
    }
}

fn bar(p: *i32) void {
    warn("p = {}\n", .{p.*});
}
