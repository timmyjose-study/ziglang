const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Point = struct {
    x: i32,
    y: i32,
};

fn foo(point: Point) i32 {
    // here, Zig may decide to either copy the argument or pass by reference. The arguments are always
    // immutable, but be careful assuming anything else about the arguments.
    return point.x + point.y;
}

test "pass struct to function" {
    assert(foo(Point{ .x = 100, .y = 200 }) == 300);
}
