const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Payload = union {
    Int: i64,
    Float: f64,
    Bool: bool,
};

test "basic unions" {
    var payload = Payload { .Float = 3.14159 };
    warn("Type of payload = {}\n", .{@typeName(@TypeOf(payload))});
    assert(payload.Float == 3.14159);

    payload = Payload { .Bool = true };
    assert(payload.Bool);

    payload = Payload { .Int = 100 };
    assert(payload.Int == 100);
}