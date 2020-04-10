const std = @import("std");
const assert = std.debug.warn;

test "assert aliased to warn" {
    const x = 12345;
    assert(x == 12345);
}
