const std = @import("std");
const assert = std.debug.assert;

test "const" {
    const x = 12345;

    {
        const y = x;
        assert(y == 12345);
    }
}

test "var" {
    const x = 12345;

    {
        var y: i32 = x;
        assert(y == 12345);

        y = x + 1;
        assert(y == 12346);
    }
}

test "undefined" {
    var x: i32 = undefined;

    {
        x = 12345;
        assert(x == 12345);
    }

    {
        x = 54321;
        assert(x == 54321);
    }
}
