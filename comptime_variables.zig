const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const CmdFn = struct {
    name: []const u8,
    func: fn (i32) i32,
};

const cmd_fns = [_]CmdFn{
    CmdFn{ .name = "one", .func = one },
    CmdFn{ .name = "two", .func = two },
    CmdFn{ .name = "three", .func = three },
};

fn one(x: i32) i32 {
    return x + 1;
}

fn two(x: i32) i32 {
    return x + 2;
}

fn three(x: i32) i32 {
    return x + 3;
}

test "comptime variables" {
    assert(performFn('t', 1) == 6);
    assert(performFn('o', 0) == 1);
    assert(performFn('w', 99) == 99);
}

fn performFn(comptime prefix_char: u8, start_value: i32) i32 {
    var result: i32 = start_value;
    comptime var i = 0;
    inline while (i < cmd_fns.len) : (i += 1) {
        if (cmd_fns[i].name[0] == prefix_char) {
            result = cmd_fns[i].func(result);
        }
    }

    return result;
}
