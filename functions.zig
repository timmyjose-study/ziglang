const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

fn add(a: i8, b: i8) i8 {
    if (a == 0) {
        return b;
    }

    return a + b;
}

test "add" {
    assert(add(10, 0) == 10);
    assert(add(1, 2) == 3);
}

// the export specifier makes the function externally visible in the object file, and makes it use the C ABI, i.e.,
// callconv(.C)
export fn sub(a: i8, b: i8) i8 {
    return a - b;
}

// the extern specifier declares a function that will be resolved at link time (static linking) or at runtime (dynamic linking)
extern "C" fn exit(exit_code: c_uint) callconv(.C) noreturn;
extern "C" fn atan2(a: f64, b: f64) f64;

test "extern" {
    warn("atan2(10, 20) = {}\n", .{atan2(10.0, 20.0)});
}

// @setCold tells the compiler that this is a less-used codepath
fn abort() noreturn {
    @setCold(true);
    while (true) {}
}

// the naked calling convention forces a function to eschew its prologue and epilogue - useful for integrating with assembly
fn _start() callconv(.Naked) noreturn {
    abort();
}

// the inline specifier forces the compiler to be inlined at all call-sites, and if it cannot be, then it is a comptime error
inline fn shiftLeftOne(x: u32) u32 {
    return (x << 1);
}

test "shiftLeftOne" {
    assert(shiftLeftOne(1) == 2);
    assert(shiftLeftOne(2) == 4);
}

// the pub specifier allows the function to be visible when being imported by another file
pub fn mul(a: i8, b: i8) i8 {
    return a * b;
}

// functions can be used as values, and are equivalent to pointers
const call2_op = fn (a: i8, b: i8) i8;

fn do_op(func: call2_op, a: i8, b: i8) i8 {
    return func(a, b);
}

fn do_c_op(func: fn (a: i8, b: i8) callconv(.C) i8, a: i8, b: i8) i8 {
    return func(a, b);
}

test "do_op" {
    assert(do_op(add, 2, 3) == 5);
    assert(do_c_op(sub, 2, 3) == -1);
    assert(do_op(mul, 2, 3) == 6);
}

test "function values are like pointers" {
    assert(@TypeOf(mul) == fn (a: i8, b: i8) i8);
    assert(@sizeOf(@TypeOf(mul)) == @sizeOf(?fn (a: i8, b: i8) i8));
}
