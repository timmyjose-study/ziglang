const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "multi-dimensional arrays" {
    const matrix = [3][3]f32{
        [_]f32{ 1.0, 0.0, 2.1 },
        [_]f32{ 2.3, 3.1, -1.2 },
        [_]f32{ -0.01, 1.23, 2424.22 },
    };

    assert(matrix[0].len == 3);
    assert(matrix.len == 3);

    for (matrix) |r| {
        for (r) |c| {
            warn("{} ", .{c});
        }
        warn("\n", .{});
    }
}

test "mutating a multi-dimensional array" {
    var array: [2][3]i32 = undefined;

    warn("Type of array = {}\n", .{@typeName(@TypeOf(array))});

    // note that mutability has to be transitive since constness is transitive
    for (array) |*r, r_idx| {
        for (r) |*c, c_idx| {
            c.* = @intCast(i32, r_idx + c_idx);
        }
    }

    for (array) |r| {
        for (r) |c| {
            warn("{} ", .{c});
        }
        warn("\n", .{});
    }
}
