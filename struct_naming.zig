const std = @import("std");
const warn = std.debug.warn;

// structS are anonymous by default in Zig. They get assigned names through any of the following three ways:
//
// 1. As the name of the variable (result-location) in an assignment operation.
// 2. As the name of the function when used with a return statement, or
// 3. As a purely anonymous struct defined in terms of the file:line:column co-ordinates.
//

fn List(comptime T: type) type {
    return struct {
        x: T,
    };
}

pub fn main() void {
    const Foo = struct {};
    warn("variables: {}\n", .{@typeName(Foo)});
    warn("functions: {}\n", .{@typeName(List(i32))});
    warn("anonymous: {}\n", .{@typeName(struct {})});
}
