const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// array literal
const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

test "get the size of an array at comptime" {
    comptime {
        assert(message.len == 5);
    }
}

// a string literal is a single-item pointer to a 0-terminated character array
const same_message = "hello";

test "string literal size at comptime" {
    comptime {
        assert(same_message.len == 5);
    }
}

test "equality of string literals and single-item pointer to character array" {
    comptime {
        assert(std.mem.eql(u8, &message, same_message));
    }
}

test "iterate over an array" {
    // the type of a character literal is comptime_int
    assert(@TypeOf('x') == comptime_int);

    var sum: i32 = 0;
    for (message) |c| {
        sum += @as(i32, c);
    }

    assert(sum == 'h' + 'e' + 'l' + 'l' + 'o');
}
