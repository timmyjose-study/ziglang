const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// In Zig, pointers cannot be null. Only optional pointers can be null, and these are unwrapped using if or orelse,
// at which point it is a pointer (and so cannot be null)
test "basic optionals" {
    var maybe_int: ?i32 = null;
    assert(maybe_int == null);

    if (maybe_int) |_| unreachable else {
        warn("maybe_int is null\n", .{});
    }

    maybe_int = 100;
    assert(maybe_int.? == 100);

    if (maybe_int) |e| {
        assert(e == 100);
    } else {
        unreachable;
    }

    const value = maybe_int orelse 0;
    assert(value == 100);

    maybe_int = null;
    const another_value = maybe_int orelse 0;
    assert(another_value == 0);
}

test "optional type" {
    var foo: ?i32 = null;

    foo = 12345;
    comptime assert(@TypeOf(foo).Child == i32);
}

test "optional pointers" {
    // pointers cannot be null - they have to be wrapped in an optional type
    var ptr: ?*i32 = null;

    var x: i32 = 100;
    ptr = &x;

    assert(ptr.?.* == 100);

    // optional pointers are the same size as regular pointers
    assert(@sizeOf(@TypeOf(ptr)) == @sizeOf(*i32));
}
