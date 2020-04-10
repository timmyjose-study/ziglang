const std = @import("std");
const assert = std.debug.assert;

test "error union Payload and ErrorSet" {
    var foo: anyerror!i32 = undefined;

    foo = 12345;
    foo = error.DummyError;

    assert(@TypeOf(foo).Payload == i32);
    assert(@TypeOf(foo).ErrorSet == anyerror);
    comptime assert(@TypeOf(foo).Payload == i32);
    comptime assert(@TypeOf(foo).ErrorSet == anyerror);
}
