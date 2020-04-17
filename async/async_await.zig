const std = @import("std");
const assert = std.debug.assert;

// suspend and resume are the lower-level primitives whereas async and await are the higher-level primitives.

fn func() void {
    suspend;
}

fn amain() void {
    var frame = async func();
    comptime assert(@TypeOf(frame) == @Frame(func));

    // await needs type anyframe->T, where T is the type of the return value whereas
    // resume requires type anyframe
    const ptr: anyframe->void = &frame;
    const any_ptr: anyframe = ptr;

    resume any_ptr;
    await ptr;
}

test "basic async await" {
    _ = async amain();
}
