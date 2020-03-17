const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "sentinel-terminated arrays" {
    const array = [_:0]i32{ 1, 2, 3, 4, 5 };
    assert(array.len == 5);
    assert(@TypeOf(array) == [5:0]i32);
    warn("type of array = {}\n", .{@typeName(@TypeOf(array))});
    assert(array[array.len] == 0);
}

test "string literals are single-item pointers to sentinel-terminated arrays" {
    const message = "hello";
    assert(message.len == 5);
    assert(message[message.len] == 0);
    assert(@TypeOf(message) == *const [5:0]u8);
    warn("type of hello = {}\n", .{@typeName(@TypeOf(message))});
}
