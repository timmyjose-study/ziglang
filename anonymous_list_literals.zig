const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "anonymous list literals" {
    var array: [5]u32 = .{ 1, 2, 3, 4, 5 };

    for (array) |e| {
        warn("{} ", .{e});
    }
    warn("\n", .{});
}

test "if the type of the result location is not specified then the anonymous list literal turns into a struct" {
    dump(.{ @as(i32, 100), @as(f64, 3.14159), true, "hello" });
}

fn dump(args: var) void {
    assert(args.@"0" == 100);
    assert(args.@"1" == 3.14159);
    assert(args.@"2");
    assert(std.mem.eql(u8, args.@"3", "hello"));
}
