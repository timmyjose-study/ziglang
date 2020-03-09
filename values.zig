const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

pub fn main() void {
    // integers
    const one_plus_one: i32 = 1 + 1;
    warn("1 + 1 = {}\n", .{one_plus_one});

    // floats
    const seven_div_three: f128 = 7.0 / 3.0;
    warn("7.0 / 3.0 = {}\n", .{seven_div_three});

    // booleans
    warn("{} and {} = {}, {} or {} = {}, !{} = {}\n", .{ true, false, true and false, true, false, true or false, false, !false });

    // optionals
    var number_or_null: ?i32 = null;
    assert(number_or_null == null);
    warn("type of number_or_null = {}\n", .{@typeName(@TypeOf(number_or_null))});

    number_or_null = 199;
    assert(number_or_null.? == 199);

    // error unions
    var number_or_error: anyerror!i32 = error.SomethingAwful;
    warn("type of number_or_error = {}, value = {}\n", .{ @typeName(@TypeOf(number_or_error)), number_or_error });

    number_or_error = 12345;
    warn("type of number_or_error = {}, value = {}\n", .{ @typeName(@TypeOf(number_or_error)), number_or_error });
}
