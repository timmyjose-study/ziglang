// Zig does not allow shadowing

const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const pi = 3.14159;

test "no shadowing allowed" {
    // this is not legal
    // const pi = 2;
}

test "the same name is allowed in parallel scopes" {
    {
        const x = 100;
        warn("x = {}\n", .{x});
    }

    {
        const x = "Hello, world";
        assert(std.mem.eql(u8, x, "Hello, world"));
    }
}
