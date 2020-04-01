const std = @import("std");
const assert = std.debug.assert;

const Number = union {
    int: i32,
    float: f64,
};

test "anonymous union literals" {
   assert(makeNumber().float == 1.2345);

   var i: Number = .{ .int = 100 };
   assert(i.int == 100);
}

fn makeNumber() Number {
    return .{ .float = 1.2345 };
}