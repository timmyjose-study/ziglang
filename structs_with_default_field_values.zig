const std = @import("std");
const assert = std.debug.assert;

const Foo = struct {
    a: i32 = 12345,
    b: i32,
};

test "default field values in structs" {
    var foo = Foo{ .a = 1, .b = 200 };
    assert(foo.a + foo.b == 201);

    foo = Foo{ .b = 1 };
    assert(foo.a + foo.b == 12346);
}
