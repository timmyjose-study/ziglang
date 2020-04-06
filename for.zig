const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "for basics" {
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    var sum: i32 = 0;

    for (numbers) |item| {
        sum += item;
    }

    assert(sum == 15);

    var slice_sum: i32 = 0;
    for (numbers[2..4]) |e| {
        slice_sum += e;
    }
    assert(slice_sum == 7);

    for (numbers) |item, idx| {
        warn("Item at index {} = {}\n", .{ idx, item });
    }
}

test "for reference" {
    var numbers = [_]u32{ 1, 2, 3, 4, 5 };
    for (numbers) |*e| {
        e.* += 100;
    }

    for (numbers) |e| {
        warn("{} ", .{e});
    }
    warn("\n", .{});
}

test "for else" {
    var items = [_]?i32{ 1, 2, null, 3, 4, null, 5 };
    var sum: i32 = 0;

    const result = for (items) |e| {
        if (e != null) {
            sum += e.?;
        }
    } else blk: {
        assert(sum == 15);
        break :blk sum;
    };

    assert(result == 15);
}
