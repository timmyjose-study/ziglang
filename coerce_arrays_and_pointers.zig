const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "cast [N]T to []const T" {
    var x1: []const u8 = "hello";
    var x2: []const u8 = &[5]u8{ 'h', 'e', 'l', 'l', 111 };
    assert(std.mem.eql(u8, x1, x2));

    var y: []const f32 = &[2]f32{ 1.2, -2.1 };
    assert(y[0] == 1.2);
    assert(y[1] == -2.1);
}

test "[N]T to E![] const T" {
    var x1: anyerror![]const u8 = "world";
    var x2: anyerror![]const u8 = &[5]u8{ 'w', 'o', 'r', 'l', 'd' };
    assert(std.mem.eql(u8, try x1, try x2));

    var y: anyerror![]const f32 = &[2]f32{ 1.2, -2.1 };
    assert((try y)[0] == 1.2);
    assert((try y)[1] == -2.1);
}

test "[N]T to ?[]const T" {
    var x1: ?[]const u8 = "again";
    var x2: ?[]const u8 = &[5]u8{ 'a', 'g', 'a', 'i', 'n' };
    assert(std.mem.eql(u8, x1.?, x2.?));

    var y: ?[]const f32 = &[2]f32{ 1.2, -2.1 };
    assert(y.?[0] == 1.2);
    assert(y.?[1] == -2.1);
}
