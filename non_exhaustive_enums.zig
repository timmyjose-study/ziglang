const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Number = enum(u8) {
    One, Two, Three, _
};

test "switch on non-exhaustive enum" {
    const number = Number.One;
    const result = switch (number) {
        .One => true,
        .Two, .Three => false,
        _ => false,
    };
    assert(result);

    const is_one = switch (number) {
        .One => true,
        else => false,
    };
    assert(is_one);
}
