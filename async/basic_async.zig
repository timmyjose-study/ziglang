const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

var x: i32 = 1;

fn func() void {
    x += 1;
    suspend; // returns control to callsite
    x += 1; // this would be reached if the suspend has a corresponding resume
}

test "suspend without resume" {
    var frame = async func();
    assert(x == 2);
}
