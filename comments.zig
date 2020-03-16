const std = @import("std");
const assert = std.debug.assert;

test "comments" {
    // Zig only has single-line comments and doc comments.
    const x = true;
    assert(x);
}
