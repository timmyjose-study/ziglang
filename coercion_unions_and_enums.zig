const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const E = enum {
    One,
    Two,
    Three,
};

const U = union(E) {
    One: i32,
    Two: f32,
    Three,
};

test "coercion between unions and enums" {
    // coercion of union to enum works regardless of the variant
    var u = U{ .One = 100 };
    var e: E = u;
    assert(e == E.One);

    // coercion from enum to union only works for void types -
    // this makese sense since this type carries no data
    const three = E.Three;
    const another_u: U = three;
    assert(another_u == E.Three);
}
