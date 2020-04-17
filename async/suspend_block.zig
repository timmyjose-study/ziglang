const std = @import("std");
const assert = std.debug.assert;

var the_frame: anyframe = undefined;
var result: bool = false;

fn testSuspendBlock() void {
    suspend {
        comptime assert(@TypeOf(@frame()) == *@Frame(testSuspendBlock));
        the_frame = @frame();
    }
    result = true;
}

test "suspend block" {
    _ = async testSuspendBlock();
    assert(!result);
    resume the_frame;
    assert(result);
}
