const std = @import("std");
const assert = std.debug.assert;

test "@TypeOf unreachable" {
    comptime {
        // the return type of unreachable is "noreturn", but this assertion will still fail
        // because evaluating unreachable at comptime is a compile error
        comptime {
            assert(@TypeOf(unreachable) == noreturn);
        }
    }
}
