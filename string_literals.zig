const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// strings are basically null terminated (0 terminated) constant fat pointers.
test "string literals" {
    const bytes = "hello";
    // 5:0 denotes a length of 5 and null termination
    assert(@TypeOf(bytes) == *const [5:0]u8);
    assert(bytes.len == 5);
    assert(bytes[1] == 'e');
    assert(bytes[bytes.len] == 0);

    assert('e' == '\x65');
    assert(std.mem.eql(u8, bytes, "h\x65llo"));
}

test "multiline string literals" {
    const hello_world_in_c =
        \\ #include <stdio.h>
        \\
        \\ int main(int argc, char *argv[])
        \\ {
        \\   printf("Hello, world!\n");
        \\ 
        \\   return 0;
        \\}
    ;

    warn("hello_world_in_c = {}\n", .{hello_world_in_c});
}
