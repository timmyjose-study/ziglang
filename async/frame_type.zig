const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

// @frame() called within an async function returns *@Frame(function_name) whereas that returned by `async function_name` is @Frame(function_name)

fn func() void {
    const self_frame_type = @frame();
    warn("self_frame_type = {}\n", .{@typeName(@TypeOf(self_frame_type))});
    assert(@TypeOf(@frame()) == *@Frame(func));
    suspend;
}

test "frame types - @frame() vs that returned by an async function" {
    const return_frame_type = async func();
    warn("return_frame_type = {}\n", .{@typeName(@TypeOf(return_frame_type))});
    assert(@TypeOf(return_frame_type) == @Frame(func));
}
