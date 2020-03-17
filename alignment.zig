const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

test "alignment values of some basic types" {
    warn("alignment of i32 = {}\n", .{@alignOf(i32)});
    warn("alignment of u32 = {}\n", .{@alignOf(u32)});
    warn("alignment of i16 = {}\n", .{@alignOf(i16)});
    warn("alignment of u16 = {}\n", .{@alignOf(u16)});
    warn("alignment of u12345 = {}\n", .{@alignOf(u12345)});
    warn("alignment of u54321 = {}\n", .{@alignOf(u54321)});
}

test "alignment of pointer types" {
    warn("alignment of *i32 = {}\n", .{@alignOf(*i32)});
    warn("alignment of *u32 = {}\n", .{@alignOf(*u32)});
    warn("alignment of *u8 = {}\n", .{@alignOf(*u8)});
    warn("alignment of *i8 = {}\n", .{@alignOf(*i8)});
    warn("alignment of *u128 = {}\n", .{@alignOf(*u128)});
}

test "variablea alignment" {
    var x: i32 = 12345;
    const alignment_of_x = @alignOf(@TypeOf(x));
    warn("alignment_of_x = {}\n", .{alignment_of_x});
    assert(@TypeOf(&x) == *i32);
    assert(*i32 == *align(alignment_of_x) i32);

    if (std.Target.current.cpu.arch == .x86_64) {
        assert(alignment_of_x == 4);
        assert((*i32).alignment == 4);
    }
}

var foo: u8 align(4) = 100;

test "global variablea alignment" {
    assert(@TypeOf(&foo).alignment == 4);
    assert(@TypeOf(&foo) == *align(4) u8);
    const slice = @as(*[1]u8, &foo)[0..];
    assert(@TypeOf(slice) == []align(4) u8);
}

fn derp() align(@sizeOf(usize) * 2) i32 {
    return 12345;
}

fn noop1() align(1) void {}
fn noop2() align(4) void {}
fn noop3() align(16) void {}

test "function alignment" {
    assert(derp() == 12345);
    assert(@TypeOf(noop1) == fn () align(1) void);
    assert(@TypeOf(noop2) == fn () align(4) void);
    assert(@TypeOf(noop3) == fn () align(16) void);
}
