const std = @import("std");
const assert = std.debug.assert;

// Zig allows type inference for the parameter type using the specifier var. @TypeOf and @typeInfo may be used to
// extract data about the concrete type of the argument.

fn addFortyTwo(x: var) @TypeOf(x) { // so that we get back the correct type
    return x + 42;
}

test "function parameter type inference" {
    assert(addFortyTwo(1) == 43);
    assert(@TypeOf(addFortyTwo(1)) == comptime_int);

    const x: i32 = 100;
    assert(addFortyTwo(x) == 142);
    assert(@TypeOf(addFortyTwo(x)) == i32);
}
