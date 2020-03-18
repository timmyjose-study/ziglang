const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Color = enum {
    Auto, On, Off
};

test "enum literals" {
    const color1: Color = .Auto;
    const color2 = Color.Auto;
    assert(color1 == color2);
}

test "switch on enum literals" {
    const c = Color.On;
    var b = switch (c) {
        .Auto => true,
        .On => true,
        .Off => false,
    };

    assert(b);
}
