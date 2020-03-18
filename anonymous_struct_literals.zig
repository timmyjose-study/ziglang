const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Point = struct {
    x: i32,
    y: i32,
};

test "anonymous struct literals" {
    const pt: Point = .{
        .x = 100,
        .y = 200,
    };

    assert(pt.x == 100);
    assert(pt.y == 200);
}

test "fully anonymous struct literal" {
    dump(.{
        .int = @as(i32, 12345),
        .float = @as(f128, 3.14159),
        .b = true,
        .s = "hello",
    });
}

fn dump(args: var) void {
    assert(args.int == 12345);
    assert(args.float == 3.14159);
    assert(args.b);
    assert(args.s[0] == 'h');
    assert(args.s[1] == 'e');
    assert(args.s[args.s.len] == 0);
}
