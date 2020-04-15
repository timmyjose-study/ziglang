const std = @import("std");
const assert = std.debug.assert;

test "wraparound operations" {
    const x: i32 = std.math.maxInt(i32);
    const min_val = x +% 1;
    assert(min_val == std.math.minInt(i32));

    const y: i32 = std.math.minInt(i32);
    const max_val = y -% 1;
    assert(max_val == std.math.maxInt(i32));
}
