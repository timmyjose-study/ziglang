const std = @import("std");

test "undefined, by definition, can be coerced into any type" {
    const foo = undefined;
    var x: i32 = foo;
    var y: bool = foo;
}
