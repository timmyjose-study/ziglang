const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

// Zig has builtin functions that return a bool which, if true, indicates overflow.
// The results are still stored in the given variable.

test "@addWithOverflow" {
    var byte: u8 = 255;

    var result: u8 = undefined;
    if (@addWithOverflow(u8, 1, byte, &result)) {
        warn("overflowed result: {}\n", .{result});
    } else {
        warn("result = {}\n", .{result});
    }
}
