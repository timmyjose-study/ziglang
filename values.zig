const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

pub fn main() void {
    // integers
    const one_plus_one: i32 = 1 + 1;
    assert(one_plus_one == 2);

    // floats
    const seven_div_three: f32 = 7.0 / 3.0;
    warn("seven_div_three = {}\n", .{seven_div_three});

    // booleans
    warn("{} and {} = {}\n{} or {} = {}\n!{} = {}\n", .{ false, true, false and true, true, false, true or false, false, !false });

    // optionals
    var string_or_null: ?[]const u8 = null;
    assert(string_or_null == null);
    warn("type of string_or_null = {}\n", .{@typeName(@TypeOf(string_or_null))});

    string_or_null = "Hola, mundo!";
    assert(std.mem.eql(u8, string_or_null.?, "Hola, mundo!"));

    // error unions
    var number_or_error: anyerror!i32 = error.SomethingAwful;
    warn("type of number_or_error = {}\n", .{@typeName(@TypeOf(number_or_error))});
    warn("number_or_error = {}\n", .{number_or_error});

    number_or_error = 100;
    //assert((try number_or_error) == 100);
    warn("number_or_error = {}\n", .{number_or_error});
}
