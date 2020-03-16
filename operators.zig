// Zig does not have Operator Overloading.

const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

test "wrapping operations" {
    assert(@as(u32, std.math.maxInt(u32)) +% 1 == 0);
    assert(@as(u32, 0) -% 1 == std.math.maxInt(u32));
}

test "bitwise operators" {
    assert(0b011 & 0b101 == 0b001);
    assert(0b011 | 0b101 == 0b111);
    assert(0b011 ^ 0b101 == 0b110);
    assert(~@as(u8, 0b011) == 0b11111100);
    assert(1 << 10 == 1024);
    assert(256 >> 8 == 1);
}

test "miscellaneous operators" {
    var number_or_null: ?i32 = null;
    assert(number_or_null orelse 100 == 100);
    number_or_null = 99;
    assert(number_or_null orelse 100 == 99);
    assert(number_or_null.? == 99);

    var string_or_error: anyerror![]const u8 = error.SomeError;
    assert(std.mem.eql(u8, string_or_error catch "error", "error"));
    string_or_error = "hola";
    assert(std.mem.eql(u8, string_or_error catch "error", "hola"));
}

test "array operators" {
    // concatenation is only for comptime-known values
    const array1 = [_]i32{ 1, 2, 3 };
    const array2 = [_]i32{ 4, 5 };
    const array3 = array1 ++ array2;
    assert(std.mem.eql(i32, &array3, &[_]i32{ 1, 2, 3, 4, 5 }));

    // multiplication is also only for comptime-known values
    const pattern = "ab" ** 3;
    assert(std.mem.eql(u8, pattern, "ababab"));
}

test "pointer dereference" {
    const x: i32 = 100;
    const ptr_x = &x;

    assert(ptr_x.* == 100);

    var y: i32 = 99;
    const ptr_y = &y;

    assert(ptr_y.* == 99);
    ptr_y.* += 1;
    assert(y == 100);
}

test "merging error sets" {
    const A = error{One};
    const B = error{Two};
    const C = A || B;

    assert(@TypeOf(C) == @TypeOf(error{
        One,
        Two,
    }));
}
