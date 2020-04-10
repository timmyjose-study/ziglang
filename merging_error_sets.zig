const std = @import("std");

const A = error{
    NotDir,
    PathNotFound,
};

const B = error{
    OutOfMemory,
    PathNotFound,
};

const C = A || B;

fn foo() C!void {
    return error.NotDir;
}

test "merging error sets" {
    if (foo()) {
        @panic("this should not have happened!");
    } else |err| switch (err) {
        error.OutOfMemory => @panic("unexpected"),
        error.PathNotFound => @panic("unexpected"),
        error.NotDir => {},
    }
}
