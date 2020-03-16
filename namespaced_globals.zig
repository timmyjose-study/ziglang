const std = @import("std");
const assert = std.debug.assert;

fn foo() i32 {
    // this is still effectively a top-level declaration
    const S = struct {
        var x: i32 = 100;
    };
    S.x += 1;
    return S.x;
}

test "namespaced global variables" {
    assert(foo() == 101);
    assert(foo() == 102);
}
