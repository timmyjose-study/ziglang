const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "nested break" {
    var count: usize = 0;

    outer: for ([_]i32{ 1, 2, 3, 4, 5 }) |o| {
        for ([_]i32{ 1, 2, 3 }) |i| {
            count += 1;
            break :outer;
        }
    }

    assert(count == 1);
}

test "nested continue" {
    var count: usize = 0;

    outer: for ([_]i32{ 1, 2, 3, 4, 5 }) |o| {
        for ([_]i32{ 1, 2, 3 }) |i| {
            count += 1;
            continue :outer;
        }
    }

    assert(count == 5);
}
