const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "type coercion - variable declaration" {
    var a: u8 = 1;
    var b: u16 = a;
    assert(a == 1);
}

test "type coercion - function call" {
    var a: u8 = 1;
    foo(a);
}

fn foo(a: u16) void {
    assert(@TypeOf(a) == u16);
}

test "type coercion - the @as builtin" {
    var a: u8 = 1;
    var b = @as(u16, a);
    assert(b == 1);
    assert(@TypeOf(b) == u16);
}

// increasing strictness

test "type coercion - non-const to const" {
    var a: i32 = 1;
    var b: *i32 = &a;
    bar(b);
}

fn bar(x: *const i32) void {
    assert(@TypeOf(x) == *const i32);
}

test "type coercion - non-volatile to volatile" {
    var a: i32 = 1;
    baz(&a);
}

fn baz(x: *volatile i32) void {
    assert(@TypeOf(x) == *volatile i32);
}

test "type coercion - bigger alignment to smaller alignment" {
    var a: u16 align(@sizeOf(u16)) = 100;
    quux(&a);
}

fn quux(x: *align(@sizeOf(u8)) u16) void {
    assert(@TypeOf(x) == *align(@sizeOf(u8)) u16);
}

test "coercing pointers to const optional pointers - cast *[1][*]const u8 to [*]const ?[*]const u8" {
    const window_name = [1][*]const u8{"window name"};
    const x: [*]const ?[*]const u8 = &window_name;
    assert(std.mem.eql(u8, std.mem.spanZ(@ptrCast([*:0]const u8, x[0].?)), "window name"));
}

// primitive widening

test "integer widening" {
    var a: u8 = 50;
    var b: u16 = a;
    var c: u32 = b;
    var d: u64 = c;
    var e: u128 = d;
    assert(e == 50);
}

test "implict widening from unsigned to signed integer" {
    var a: u8 = 100;
    var b: i16 = a;
    assert(b == 100);
}

test "float widening" {
    var a: f16 = 1.2345;
    var b: f32 = a;
    var c: f64 = b;
    var d: f128 = c;
    assert(d == a);
}
