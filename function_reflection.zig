const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

fn add(x: i32, y: i32) i32 {
    return x + y;
}

test "function introspection" {
    assert(@TypeOf(add).ReturnType == i32);
    assert(!(@TypeOf(add).is_var_args));
}
