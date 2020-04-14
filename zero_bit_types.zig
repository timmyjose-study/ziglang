const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// zero-bit types are types for which @sizeOf is 0.

test "void" {
    // void can be useful for instantiating generic types
    var map = std.HashMap(i32, void, hash_i32, eql_i32).init(std.testing.allocator);
    defer map.deinit();

    _ = try map.put(1, {});
    _ = try map.put(2, {});

    assert(map.contains(1));
    assert(map.contains(2));
    assert(!map.contains(3));

    _ = map.remove(2);
    assert(!map.contains(2));
}

fn hash_i32(x: i32) u32 {
    return @bitCast(u32, x);
}

fn eql_i32(x: i32, y: i32) bool {
    return x == y;
}

test "void vs c_void" {
    warn("size of void = {}\n", .{@sizeOf(void)});
    //warn("size of c_void = {}\n", .{@sizeOf(c_void)});
}

test "void is the only type whose return value can be ignored" {
    foo();
    // whereas for any other type
    _ = bar();
}

fn foo() void {}

fn bar() i32 {
    return 12345;
}

test "pointers to zero-bit types are also zero-bit types" {
    const Empty = struct {};
    const a = Empty{};
    const b = Empty{};
    const ptr_a = &a;
    const ptr_b = &b;
    comptime assert(ptr_a == ptr_b); // this is always true
}
