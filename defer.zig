const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// defer simply executes an expression at the end of the current scope.
// When there are multiple deferS, they will be run in the opposite order of
// their declaration (basically like a stack) for the given scope.
fn deferExample() usize {
    var a: usize = 1;
    {
        defer a = 5;

        {
            defer a = 2;
            a = 1;
            assert(a == 1);
        }

        assert(a == 2);
    }
    return a;
}

test "deferExample" {
    assert(deferExample() == 5);
}

fn deferUnwindExample() void {
    defer warn("\n", .{});

    defer {
        warn("1 ", .{});
    }

    defer {
        warn("2 ", .{});
    }

    if (false) {
        // this will not run, of course
        defer {
            warn("3 ", .{});
        }
    }
}

test "deferUnwindExample" {
    deferUnwindExample();
}

// errdefer is the same as defer except that it is run only when there is an error in the given scope.
fn deferErrorExample(is_error: bool) !void {
    warn("\nStart of function...\n", .{});

    defer {
        warn("End of function\n", .{});
    }

    errdefer {
        warn("This scope attempted to return with an error!\n", .{});
    }

    if (is_error) {
        return error.ThisisTheErrorThatTriggersTheErrDefer;
    }
}

test "deferErrorExample" {
    deferErrorExample(false) catch {};
    deferErrorExample(true) catch {};
}
