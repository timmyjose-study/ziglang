const std = @import("std");
const assert = std.debug.assert;

var x: i32 = 1;

fn func() void {
    x += 1;
    suspend;
    x += 1;
}

test "suspend with resume" {
    var frame = async func();
    assert(x == 2);
    resume frame;
    assert(x == 3);
}
