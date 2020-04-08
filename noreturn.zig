const std = @import("std");
const assert = std.debug.assert;

// noreturn is the type of:
//
// 1. break
// 2. continue
// 3. return
// 4. unreachable
// 5. while (true) {} - an infinite loop that never returns
//
// Also note that because of its special nature, noreturn is compatible with every other return type - this is how switch with break or continue
// works, for instance.
//

fn foo(condition: bool, b: u32) void {
    const a = if (condition) b else return;
    @panic("do something with a!");
}

test "noreturn" {
    foo(false, 1);
}

pub extern "kernel32" fn ExitProcess(exit_code: c_uint) noreturn;

test "bar" {
    const value = bar() catch ExitProcess(1);
    assert(value == 12345);
}

fn bar() anyerror!u32 {
    return 12345;
}
