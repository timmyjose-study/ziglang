const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "inline for loop" {
    const indices = [_]usize{ 2, 4, 6 };
    var sum: usize = 0;

    inline for (indices) |idx| {
        const T = switch (idx) {
            2 => bool,
            4 => f32,
            6 => []const u8,
            else => unreachable,
        };

        sum += typeNameLength(T);
    }

    assert(sum == 17);
}

fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}
