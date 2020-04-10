const std = @import("std");

const Error = error{Overflow};

pub fn add_inferred(comptime T: type, a: T, b: T) !T {
    var answer: T = undefined;

    return if (@addWithOverflow(T, a, b, &answer)) error.Overflow else answer;
}

pub fn add_explicit(comptime T: type, a: T, b: T) Error!T {
    var answer: T = undefined;
    return if (@addWithOverflow(T, a, b, &answer)) error.Overflow else answer;
}

test "inferred error sets" {
    if (add_inferred(u8, 255, 1)) |_| unreachable else |err| switch (err) {
        error.Overflow => {},
    }
}
