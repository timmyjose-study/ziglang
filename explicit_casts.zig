const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "@bitCast" {
    const x: i32 = 100;
    const y = @bitCast(f32, x);
    warn("{}\n", .{y});
}

test "@alignCast" {
    const x: u32 align(1) = 0x12121212;
    const y = @alignCast(4, &x);
    warn("{}\n", .{y.*});
}

test "@boolToInt" {
    const x = false;
    assert(@boolToInt(x) == 0);
    const y = true;
    assert(@boolToInt(y) == 1);
}

const E = enum {
    One,
    Two,
    Three,
};

const TE = enum(u32) {
    One = 1,
    Ten = 10,
    Thousand = 1000,
};

test "@enumToInt" {
    assert(@enumToInt(E.One) == 0);
    assert(@enumToInt(E.Two) == 1);
    assert(@enumToInt(E.Three) == 2);
    assert(@enumToInt(TE.One) == 1);
    assert(@enumToInt(TE.Ten) == 10);
    assert(@enumToInt(TE.Thousand) == 1000);
}

const FooError = error{
    ErrorOne,
    ErrorTwo,
};

const BarError = error{ErrorOne};

test "@errSetCast" {
    const a: BarError = BarError.ErrorOne;
    const b: FooError = a;
    assert(b == FooError.ErrorOne);
    const c: BarError = @errSetCast(BarError, b);
    assert(c == BarError.ErrorOne);
}

test "@errorToInt" {
    // note that the exact int value is not stable, so this should be avoided when possible
    warn("{}\n", .{@errorToInt(FooError.ErrorOne)});
    warn("{}\n", .{@errorToInt(FooError.ErrorTwo)});
    warn("{}\n", .{@errorToInt(BarError.ErrorOne)});
}

test "@floatCast" {
    const f: f32 = 1.2345;
    const ff = @floatCast(f16, f);
    warn("{}\n", .{ff});
}

test "@floatToInt" {
    const f: f64 = 1.2345;
    assert(@floatToInt(u32, f) == 1);
}

test "@intCast" {
    const i: i128 = 12345;
    const ii = @intCast(i16, i);
    assert(ii == 12345);
}

test "@intToEnum" {
    assert(@intToEnum(E, 0) == E.One);
    assert(@intToEnum(E, 1) == E.Two);
    assert(@intToEnum(E, 2) == E.Three);
}

test "@intToError" {
    // just like @errorToInt, this is neither reliable nor stable - avoid using it.
    warn("{}\n", .{@intToError(1)});
    warn("{}\n", .{@intToError(2)});
}

test "@intToFloat" {
    const i: i32 = 12345;
    const f = @intToFloat(f64, i);
    warn("{}\n", .{f});
}

test "@intToPtr" {
    const i: usize = 0x12345678;
    const p = @intToPtr(*i32, i);
    warn("{}\n", .{p});
}

test "@ptrCast" {
    var a: i32 = 100;
    var pa: *i32 = &a;
    const c = @ptrCast(*u32, pa);
    assert(c.* == 100);
}

test "@ptrToInt" {
    var a: i32 = 100;
    const p = &a;
    const i = @ptrToInt(p); // usize
    warn("{}\n", .{i});
}

test "@truncate" {
    const a: i64 = 1234556893823982;
    const b = @truncate(u8, a);
    warn("{}\n", .{b});
}
