const std = @import("std");
const assert = std.debug.assert;

test "basic maths" {
    const x = 1;
    const y = 2;

    if (x + y != 3) {
        unreachable;
    }

    assert(x + y == 3);
}

fn myAssert(ok: bool) void {
    if (!ok) {
        unreachable;
    }
}

test "myAssert" {
    myAssert(true);
    myAssert(1 + 1 == 3); // this should fail
}
