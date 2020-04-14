const std = @import("std");

test "zero-bit types can be coerced to single-item pointers" {
    var x: void = {};
    var y: *void = x;
}
