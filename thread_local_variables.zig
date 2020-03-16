const std = @import("std");
const assert = std.debug.assert;

// a threadlocal variable is restricted to be visible to the current thread, meaning that each
// thread gets its own copy.
threadlocal var x: i32 = 100;

test "thread local storage" {
    const thread1 = try std.Thread.spawn({}, testTls);
    const thread2 = try std.Thread.spawn({}, testTls);
    testTls({});
    thread1.wait();
    thread2.wait();
}

fn testTls(ctx: void) void {
    assert(x == 100);
    x += 1;
    assert(x == 101);
}
