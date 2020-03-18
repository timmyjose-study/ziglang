const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "null terminated slice" {
    const slice: [:0]const u8 = "hello";
    assert(slice.len == 5);
    assert(slice[slice.len] == 0);
}
