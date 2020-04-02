const std = @import("std");
const assert = std.debug.assert;

const Color = enum {
    Auto, On, Off
};

test "exhaustive switching without else" {
    const color = Color.Off;

    switch (color) {
        Color.Off => {},
        Color.On => {},
        Color.Auto => {}, // error if this is not included
    }
}

test "non-exhaustive switching with else" {
    const color = Color.Auto;

    switch (color) {
        Color.Off => {},
        else => {},
    }
}
