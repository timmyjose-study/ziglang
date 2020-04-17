const std = @import("std");
const assert = std.debug.assert;

var the_frame: anyframe = undefined;

test "resume from suspend" {
    var x: i32 = 1;
    _ = async func(&x);
    assert(x == 2);
    resume the_frame;
    assert(x == 3);
}

fn func(ptr_x: *i32) void {
    // this whole block is essentially a no-op
    suspend {
        the_frame = @frame();
        resume @frame();
    }

    ptr_x.* += 1;
    suspend;
    ptr_x.* += 1;
}
