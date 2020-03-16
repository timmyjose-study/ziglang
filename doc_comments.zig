const std = @import("std");
const assert = std.debug.assert;

/// Represents a timestamp holding the elapsed time since the Unix Epoch
const Timestamp = struct {
    seconds: i64,
    nanos: i64,

    /// structs can also hold functions
    pub fn unixEpoch() Timestamp {
        return Timestamp{
            .seconds = 0,
            .nanos = 0,
        };
    }
};

test "unix epoch" {
    const epoch = Timestamp.unixEpoch();
    assert(epoch.seconds == 0);
    assert(epoch.nanos == 0);
}
