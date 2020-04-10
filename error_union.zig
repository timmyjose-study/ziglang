const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

pub fn parseU64(buf: []const u8, radix: u8) !u64 {
    var x: u64 = 0;

    for (buf) |c| {
        const digit = charToDigit(c);

        if (digit >= radix) {
            return error.InvalidChar;
        }

        // x *= radix
        if (@mulWithOverflow(u64, x, radix, &x)) {
            return error.Overflow;
        }

        // x += digit
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

test "parse u64" {
    const result = try parseU64("12345", 10);
    assert(result == 12345);
    warn("{}, {}\n", .{ result, @typeName(@TypeOf(result)) });
}
