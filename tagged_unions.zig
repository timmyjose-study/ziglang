const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const ComplexTypeTag = enum {
    Ok,
    NotOk,
};

const ComplexType = union(ComplexTypeTag) {
    Ok: u8,
    NotOk: void,
};

test "tagged unions" {
    const c = ComplexType { .Ok = 128 };
    warn("Tag Type of c = {}\n", .{@typeName(@TagType(@TypeOf(c)))});

    // tagged unions coerce to their tag type (which is an enum, of course)
    assert(@as(ComplexTypeTag, c) == ComplexTypeTag.Ok);

    switch (c) {
        ComplexTypeTag.Ok => warn("alles gut!\n",.{}),
        ComplexTypeTag.NotOk => warn("not so good, boss\n", .{})
    }

    // extracting the value of a tagged union
    const answer = ComplexType { .Ok = 42 };
    switch (answer) {
        ComplexTypeTag.Ok => |v| warn("Got the answer: {}\n", .{v}),
        ComplexTypeTag.NotOk => unreachable
    }
}

test "@TagType" {
    assert(@TagType(ComplexType) == ComplexTypeTag);
}

test "coerce to enum" {
    const c1 = ComplexType { .Ok = 42 };
    const c2 = ComplexType.NotOk;

    assert(c1 == .Ok);
    assert(c2 == .NotOk);

    const answer = switch (c1) {
        .Ok => |v| v,
        .NotOk => -1,
        
    };

    assert(answer == 42);
}

test "modifying a tagged union value in a switch" {
    var c = ComplexType { .Ok = 100 };
    assert(@as(ComplexTypeTag, c) == ComplexTypeTag.Ok);
    assert(c.Ok == 100);

    switch (c) {
        ComplexTypeTag.Ok => |*value| value.* -= 1,
        ComplexTypeTag.NotOk => unreachable,
    }

    assert(c.Ok == 99);
}
