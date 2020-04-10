const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "errdefer" {
    foo(false) catch unreachable;
    foo(true) catch {};
}

fn foo(b: bool) !void {
    warn("Inside foo...\n", .{});

    defer warn("Leaving foo,,,\n", .{});

    errdefer warn("Got an error!\n", .{});

    if (b) {
        return error.SomethingWentWrong;
    }
}
