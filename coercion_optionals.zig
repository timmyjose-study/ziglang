const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "the Payload of an optional type and null coerce to an optional type" {
    var x: ?i32 = 12345;
    assert(@TypeOf(x) == ?i32);
    assert(x.? == 12345);
    x = null;
    assert(@TypeOf(x) == ?i32);
    assert(x == null);
}

test "coerce to optionals wrapped inside error unions" {
    const x: anyerror!?i32 = 12345;
    const y: anyerror!?i32 = null;
    assert(@TypeOf(x) == anyerror!?i32);
    assert((try x).? == 12345);
    assert(@TypeOf(y) == anyerror!?i32);
    assert((try y) == null);
}
