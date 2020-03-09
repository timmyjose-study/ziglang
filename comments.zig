const assert = @import("std").debug.assert;

test "comments" {
    // this is a single-line comment.
    // there are not multiline comments in zig, except for documentation comments.
    const x = true;
    assert(x);
}
