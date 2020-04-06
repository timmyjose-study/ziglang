const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "if expressions" {
    const a: u32 = 1;
    const b: u32 = 2;
    const c = if (a != b) 42 else a + b;
    assert(c == 42);
}

test "if with bools" {
    const a: u32 = 1;
    const b: u32 = 2;

    if (a != b) {
        assert(true);
    } else if (a == 100) {
        unreachable;
    } else {
        unreachable;
    }
}

test "if with optionals" {
    var a: ?u32 = 0;

    if (a) |e| {
        assert(e == 0);
    } else {
        unreachable;
    }

    a = null;

    if (a) |_| {
        unreachable;
    } else {
        assert(a == null);
    }

    a = 0;
    if (a) |e| {
        assert(e == 0);
    }

    a = null;
    if (a) |_| {} else {
        assert(true);
    }

    a = 100;
    if (a) |*e| {
        e.* += 100;
    }

    assert(a.? == 200);
}

test "if with error unions" {
    var a: anyerror!u32 = 0;

    if (a) |e| {
        assert(e == 0);
    } else |_| {
        unreachable;
    }

    a = error.SomethingAwful;
    if (a) |_| {
        unreachable;
    } else |err| {
        assert(err == error.SomethingAwful);
    }

    a = 200;
    if (a) |e| {
        assert(e == 200);
    } else |_| {
        // this block is required in order to disambiguate if with optionals from if with error unions
        unreachable;
    }

    a = error.FooBarError;
    if (a) |_| {
        unreachable;
    } else |err| {
        assert(true);
        assert(err == error.FooBarError);
    }

    a = 100;
    if (a) |*e| {
        e.* += 100;
    } else |_| {}

    assert((try a) == 200);
}
