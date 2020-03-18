// packed enums have a defined memory layout - the size of the enum is the same as the integer tag type of the enum.
// packed enums can be part of a packed struct.

const std = @import("std");
const assert = std.debug.assert;

test "packed enums" {
    const JsonType = packed enum(u8) {
        Null, Number, String, Boolean, Array, Object
    };

    assert(@sizeOf(JsonType) == @sizeOf(u8));
}
