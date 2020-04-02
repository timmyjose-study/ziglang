const std = @import("std");
const warn = std.debug.warn;

const Color = enum {
    Auto,
    Off,
    On,
};

test "enum literals with switch" {
    const color = Color.Off;

    switch (color) {
        .Auto => unreachable,
        .On => unreachable,
        .Off => warn("The colour is indeed \"Off\"", .{}),
    }
}
