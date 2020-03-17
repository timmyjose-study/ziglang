const std = @import("std");
const warn = std.debug.warn;

pub extern "c" fn printf(format: [*:0]const u8, ...) c_int;

test "sentinel-terminated pointers" {
    _ = printf("Hello, world!\n");

    const message = "Hola, mundo!\n";
    _ = printf(message);

    const non_null_terminated_string: [message.len]u8 = message.*;
    //_ = printf(&non_null_terminated_string);
    warn("{}", .{non_null_terminated_string});
}
