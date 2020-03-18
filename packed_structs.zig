const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Full = packed struct {
    number: u16,
};

const Divided = packed struct {
    half1: u8,
    quarter3: u4,
    quarter4: u4,
};

test "packed structs can participate in @bitCast and @ptrCast" {
    doTheTest();
    comptime doTheTest();
}

fn doTheTest() void {
    assert(@sizeOf(Full) == 2);
    assert(@sizeOf(Divided) == 2);

    var full = Full{ .number = 0x1234 };
    var divided = @bitCast(Divided, full);

    switch (builtin.endian) {
        .Big => {
            assert(divided.half1 == 0x12);
            assert(divided.quarter3 == 0x3);
            assert(divided.quarter4 == 0x4);
        },

        .Little => {
            assert(divided.half1 == 0x34);
            assert(divided.quarter3 == 0x2);
            assert(divided.quarter4 == 0x1);
        },
    }
}

const BitField = packed struct {
    a: u3,
    b: u2,
    c: u2,
};

test "pointer to non-byte-aligned field" {
    var foo = BitField{
        .a = 1,
        .b = 2,
        .c = 3,
    };

    const ptr_a = &foo.a;
    assert(ptr_a.* == 1);
    warn("type of ptr_a = {}\n", .{@typeName(@TypeOf(ptr_a))});

    const ptr_b = &foo.b;
    assert(ptr_b.* == 2);
    warn("type of ptr_b = {}\n", .{@typeName(@TypeOf(ptr_b))});

    const ptr_c = &foo.c;
    assert(ptr_c.* == 3);
    warn("type of ptr_c = {}\n", .{@typeName(@TypeOf(ptr_c))});
}

test "pointer to non-byte-aligned fields share the same byte address" {
    comptime {
        assert(@byteOffsetOf(BitField, "a") == 0);
        assert(@byteOffsetOf(BitField, "a") == 0);
        assert(@byteOffsetOf(BitField, "c") == 0);
    }

    comptime {
        assert(@bitOffsetOf(BitField, "a") == 0);
        assert(@bitOffsetOf(BitField, "b") == 3);
        assert(@bitOffsetOf(BitField, "c") == 5);
    }

    var bar = BitField{
        .a = 1,
        .b = 2,
        .c = 3,
    };

    const ptr_a = &bar.a;
    const ptr_b = &bar.b;
    const ptr_c = &bar.c;

    assert(@ptrToInt(ptr_a) == @ptrToInt(ptr_b));
    assert(@ptrToInt(ptr_b) == @ptrToInt(ptr_c));
    assert(@ptrToInt(ptr_a) == @ptrToInt(&bar));
}
