const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// Peer-type resolution is basically choosing a type that all the expressions/values in question can automatically coerce into.
// Places where this happens:
//
// 1. switch expressions.
// 2. if expressions.
// 3. while and for expressions.
// 4. multiple break statements in a block, and
// 5. some binary operations.
//

test "peer resolve int widening" {
    var a: i8 = 100;
    var b: i16 = 34;
    var c = a + b;

    assert(c == 134);
    assert(@TypeOf(c) == i16);
}

test "peer resolve arrays of different size to const slice" {
    assert(std.mem.eql(u8, boolToStr(true), "true"));
    assert(std.mem.eql(u8, boolToStr(false), "false"));
}

fn boolToStr(b: bool) []const u8 {
    return if (b) "true" else "false";
}

test "peer resolve array and const slice" {
    testPeerResolveArrayAndConstSlice(true);
    comptime testPeerResolveArrayAndConstSlice(true);
}

fn testPeerResolveArrayAndConstSlice(b: bool) void {
    const value1 = if (b) "aeiou" else @as([]const u8, "asdf");
    const value2 = if (b) @as([]const u8, "asdf") else "aeiou";
    assert(std.mem.eql(u8, value1, "aeiou"));
    assert(std.mem.eql(u8, value2, "asdf"));
}

test "peer type resolution: ?T and T" {
    assert(peerTypeTAndOptionalT(true, false).? == 0);
    assert(peerTypeTAndOptionalT(false, false).? == 3);
    comptime {
        assert(peerTypeTAndOptionalT(true, false).? == 0);
        assert(peerTypeTAndOptionalT(false, false).? == 3);
    }
}

fn peerTypeTAndOptionalT(c: bool, b: bool) ?usize {
    if (c) {
        return if (b) null else @as(usize, 0);
    }

    return @as(usize, 3);
}

test "peer type resolution: *[0]u8 and []const u8" {
    assert(peerTypeEmptyArrayAndConstSlice(true, "hi").len == 0);
    assert(peerTypeEmptyArrayAndConstSlice(false, "hi").len == 1);
    comptime {
        assert(peerTypeEmptyArrayAndConstSlice(true, "hi").len == 0);
        assert(peerTypeEmptyArrayAndConstSlice(false, "hi").len == 1);
    }
}

fn peerTypeEmptyArrayAndConstSlice(a: bool, slice: []const u8) []const u8 {
    if (a) {
        return &[_]u8{};
    }

    return slice[0..1];
}

test "peer type resolution: *[0]u8, []const u8, and anyerror![]u8" {
    {
        var data = "hi".*;
        const slice = data[0..];
        assert((try peerTypeEmptyArrayConstSliceAndError(true, slice)).len == 0);
        assert((try peerTypeEmptyArrayConstSliceAndError(false, slice)).len == 1);
    }

    comptime {
        var data = "hi".*;
        const slice = data[0..];
        assert((try peerTypeEmptyArrayConstSliceAndError(true, slice)).len == 0);
        assert((try peerTypeEmptyArrayConstSliceAndError(false, slice)).len == 1);
    }
}

fn peerTypeEmptyArrayConstSliceAndError(a: bool, slice: []u8) anyerror![]u8 {
    if (a) {
        return &[_]u8{};
    }

    return slice[0..1];
}

test "peer type resolution: *const T and ?*T" {
    const a = @intToPtr(*const usize, 0x123456780);
    const b = @intToPtr(?*usize, 0x123456780);
    assert(a == b);
    assert(b == a);
}
