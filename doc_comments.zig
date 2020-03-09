const assert = @import("std").debug.assert;

/// This is a doc comment, it should only appear before items that represent a structure, union, enum, error union, function,
/// or some other syntactic entity that represents an item in the Zig language
/// represents a timestamp representing the elapsed time since the Unix Epoch
const Timestamp = struct {
    seconds: i64,
    nanos: i64,

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
