const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce subset to superset" {
    const oom = foo(AllocationError.OutOfMemory);
    assert(oom == FileOpenError.OutOfMemory);
}

fn foo(err: AllocationError) FileOpenError {
    return err; // coercing
}

test "casting works for coercing a superset to a subset" {
    const oom = bar(FileOpenError.OutOfMemory);
    assert(oom == AllocationError.OutOfMemory);

    // this will not work, of course
    //const ad = bar(FileOpenError.AccessDenied);
}

fn bar(err: FileOpenError) AllocationError {
    // this works, but will cause a crash if the error variant is not present in
    // the subset error type
    return @errSetCast(AllocationError, err);
}
