const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "the Payload type of an error union as well as the Error Set type coerce to the error union type" {
    var x: anyerror!i32 = 12345;
    assert(@TypeOf(x) == anyerror!i32);
    assert((try x) == 12345);
    x = error.SomethingWentWrong;
    assert(@TypeOf(x) == anyerror!i32);
    std.testing.expectError(error.SomethingWentWrong, x);

    if (x) |_| {
        unreachable;
    } else |err| {
        assert(err == error.SomethingWentWrong);
    }
}
