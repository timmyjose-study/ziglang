const std = @import("std");
const assert = std.debug.assert;

const Point = struct {
    x: i32,
    y: i32,

    pub fn new(x: i32, y: i32) Point {
        return Point{
            .x = x,
            .y = y,
        };
    }
};

fn foo(p: Point) void {
    assert(p.x == 100);
    assert(p.y == 200);
}

test "copy semantics" {
    const pt = Point.new(100, 200);
    const a = pt;
    const b = pt;
    foo(pt);
}
