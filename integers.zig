const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "integer literals" {
    const decimal_int = 10;
    const binary_int = 0b1010;
    const octal_int = 0o12;
    const hexadecimal_int = 0x0a;

    assert(decimal_int == binary_int);
    assert(binary_int == octal_int);
    assert(octal_int == hexadecimal_int);

    const arbitrary_width_integer: i1245 = 100;
    warn("type of arbitrary_width_integer = {}\n", .{@typeName(@TypeOf(arbitrary_width_integer))});
    assert(arbitrary_width_integer == 100);
}
