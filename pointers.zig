const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "address of syntaxs" {
    const x: i32 = 100;
    const ptr_x = &x;
    assert(ptr_x.* == 100);
    assert(@TypeOf(ptr_x) == *const i32);

    var y: i32 = 99;
    const ptr_y = &y;
    assert(ptr_y.* == 99);
    assert(@TypeOf(ptr_y) == *i32);
    ptr_y.* += 1;
    assert(ptr_y.* == 100);
    assert(y == 100);
}

test "pointer array access" {
    var array = [_]i32{ 1, 2, 3, 4, 5 };
    const ptr = &array[2];
    assert(ptr.* == 3);
    assert(@TypeOf(ptr) == *i32);
    ptr.* += 100;
    assert(ptr.* == 103);
    assert(array[2] == 103);
}

test "pointer slicing" {
    var array = [_]i32{ 10, 11, 12, 13, 14, 15 };
    const slice = array[2..4];
    assert(slice.len == 2);
    assert(slice[0] == 12);
    assert(slice[1] == 13);
    slice[0] += 10;
    slice[1] -= 10;
    assert(array[2] == 22);
    assert(array[3] == 3);
}

test "comptime pointers" {
    comptime {
        var x: i32 = 1;
        const ptr_x = &x;
        assert(ptr_x.* == 1);
        ptr_x.* += 100;
        assert(x == 101);
    }
}

test "@intToPtr and @ptrToInt" {
    const ptr = @intToPtr(*i32, 0xdeadbeef0);
    const addr = @ptrToInt(ptr);
    assert(@TypeOf(addr) == usize);
    assert(addr == 0xdeadbeef0);
}

test "comptime @intToPtr" {
    // this works so long as the pointer is never dereferenced
    comptime {
        const ptr = @intToPtr(*i32, 0xdeadbeef0);
        const addr = @ptrToInt(ptr);
        assert(@TypeOf(addr) == usize);
        assert(addr == 0xdeadbeef0);
    }
}
