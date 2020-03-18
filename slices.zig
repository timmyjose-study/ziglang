const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// a slice in Zig, just like in other languages, is a fat pointer to
// a region of an array.
test "basic slices" {
    var nums = [_]i32{ 1, 2, 3, 4, 5 };
    const slice = nums[2..4];
    assert(slice.len == 2);
    assert(slice[0] == 3);
    assert(slice[1] == 4);
    assert(&slice[0] == &nums[2]);
    assert(&slice[1] == &nums[3]);

    // Using & gives a single-iterm pointer whereas using the ptr field gives a
    // variable-length pointer
    assert(@TypeOf(&slice[0]) == *i32);
    assert(@TypeOf(slice.ptr) == [*]i32);
    assert(@ptrToInt(slice.ptr) == @ptrToInt(&slice[0]));
}

test "string slices" {
    // Strings in Zig are basically byte slices: []u8 or []const u8
    const hello: []const u8 = "hello";
    const privet = "привет";

    var buffer: [100]u8 = undefined;
    const buffer_slice = buffer[0..];
    assert(@TypeOf(buffer_slice) == []u8);
    const hellohello = try std.fmt.bufPrint(buffer_slice, "{}{}", .{ hello, privet });
    warn("hellohello = {}\n", .{hellohello});
    assert(hellohello.len == hello.len + privet.len);
    assert(std.mem.eql(u8, hellohello, "helloпривет"));
}

test "slice pointer" {
    var array: [100]u8 = undefined;
    const ptr = &array;

    const ptr_prime = &array[0];
    assert(@TypeOf(ptr_prime) == *u8);

    // the slice syntax works on a pointer as well
    assert(@TypeOf(ptr) == *[100]u8);
    const slice1 = ptr[0..];
    assert(slice1.len == 100);

    const slice2 = ptr[1..3];
    assert(@TypeOf(slice2) == []u8);
    assert(slice2.len == 2);
    slice2[0] = 'a';
    slice2[1] = 'b';
    warn("array = {}\n", .{array});

    const slice3 = slice2[0..];
    assert(slice3.len == 2);
    assert(slice3[0] == slice2[0]);
    assert(slice3[1] == slice2[1]);
}

test "slice widening" {
    const array align(@alignOf(u32)) = [_]u8{ 0x12, 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0x13 };
    const slice = std.mem.bytesAsSlice(u32, array[0..]);
    assert(slice.len == 2);
    assert(slice[0] == 0x12121212);
    assert(slice[1] == 0x13131313);
}
