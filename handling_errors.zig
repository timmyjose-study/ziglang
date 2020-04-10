const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// What would we like to do at the call-site of a function that returns an error-union?
//
// 1. Return a default value in case of error.
// 2. Propagate the same error upwards in the call chain.
// 3. Unconditionally unwrap the error if we know that it cannot possibly fail, or
// 4. Handle every kind of error separately.
//

fn parseU64(buf: []const u8, radix: u8) !u64 {
    var x: u64 = 0;

    for (buf) |c| {
        const digit = charToDigit(c);

        if (digit == radix) {
            return error.InvalidChar;
        }

        if (@mulWithOverflow(u64, x, radix, &x)) {
            return error.Overflow;
        }

        if (@addWithOverflow(u64, x, digit, &x)) {
            return error.Overflow;
        }
    }

    return x;
}

fn charToDigit(c: u8) u8 {
    return switch (c) {
        '0'...'9' => c - '0',
        'a'...'z' => c - 'a' + 10,
        'A'...'Z' => c - 'A' + 10,
        else => std.math.maxInt(u8),
    };
}

test "catch - return default value in case of error" {
    const parse_or_zero = parseU64("123a", 10) catch 0;
    assert(parse_or_zero == 0);
}

test "catch unreachable - unwrap value unconditionally" {
    const result = parseU64("12345", 10) catch unreachable;
    assert(result == 12345);
}

test "try - unwrap value or propagate error" {
    const res1 = parseU64("12345", 10) catch |err| return err;
    assert(res1 == 12345);

    // shorcut for above
    const res2 = try parseU64("12345", 10);
    assert(res2 == 12345);
}

test "switch - handle all errors" {
    checkErrors("12345", 10);
    checkErrors("123ab", 10);
    checkErrors("111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222", 10);
}

fn checkErrors(input: []const u8, base: u8) void {
    if (parseU64(input, base)) |val| {
        assert(val == 12345);
    } else |err| switch (err) {
        error.Overflow => {
            warn("Got an overflow\n", .{});
        },
        error.InvalidChar => {
            warn("Got an invalid char\n", .{});
        },
    }
}
