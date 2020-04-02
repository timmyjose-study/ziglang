const std = @import("std");
const assert = std.debug.assert;

fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}

test "inline while - useful for comptime operations" {
    comptime var i = 0;
    var sum: usize = 0;

    inline while (i < 3) : (i += 1) {
        const T = switch (i) {
            0 => bool,
            1 => f32,
            2 => []const u8,
            else => unreachable,
        };

        sum += typeNameLength(T);
    } else {
        assert(sum == 17);
    }
}
