const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Variant = union(enum) {
    Int: i32,
    Bool: bool,
    None, // void is implied

    // unions can have methods as well
    fn truthy(self: Variant) bool {
        return switch (self) {
            .Int => |d| d != 0,
            .Bool => |b| b,
            .None => false,
        };
    }
};

test "infer the enum tag type" {
    var v = Variant { .Int = 0 };
    assert(!v.truthy());
    v = Variant { .Int = 100 };
    assert(v.truthy());

    v = Variant { .Bool = true };
    assert(v.truthy());

    v = Variant.None;
    assert(!v.truthy());
}

const Small2 = union(enum) {
    A: i32,
    B: bool,
    C: u8,
};

test "@tagName" {
    assert(std.mem.eql(u8, @tagName(Small2.C), "C"));
}