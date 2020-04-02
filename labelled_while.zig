const std = @import("std");
const assert = std.debug.assert;

test "labelled break" {
    outer: while (true) {
        inner: while (true) {
            break :outer;
        }
    }
}

test "labelled continue" {
    var i: usize = 0;

    outer: while (i < 10) : (i += 1) {
        while (true) {
            continue :outer;
        }
    }

    assert(i == 10);
}
