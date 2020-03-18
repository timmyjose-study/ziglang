const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// enums are purely enumerated types in Zig unlike in Rust, where enumerations and tagged unions are conflated.

const Type = enum {
    Ok,
    NotOk,
};

test "basic enums" {
    var status: Type = undefined;
    status = .Ok;
    assert(status == Type.Ok);
    status = .NotOk;
    assert(status == .NotOk);
}

// we can specify an explicit tag type for an enum, which acts as its "ordinal" value type
const Value = enum(u2) {
    Zero,
    One,
    Two,
};

// we can override the default ordinal value (which starts numbering from 0) of an enum
const Value2 = enum(u32) {
    Hundred = 100,
    Thousand = 1000,
    Million = 1000000,
};

test "@enumToInt" {
    // we can obtain the ordinal value of an enum by using @enumToint
    assert(@enumToInt(Type.Ok) == 0);
    assert(@enumToInt(Type.NotOk) == 1);

    assert(@enumToInt(Value.Zero) == 0);
    assert(@enumToInt(Value.One) == 1);
    assert(@enumToInt(Value.Two) == 2);

    assert(@enumToInt(Value2.Hundred) == 100);
    assert(@enumToInt(Value2.Thousand) == 1000);
    assert(@enumToInt(Value2.Million) == 1000000);
}

// functions in enums are the same as in structs - basically namespaced functions with some magic (as allowing the dot syntax)
const Suit = enum {
    Clubs,
    Diamonds,
    Hearts,
    Spades,

    pub fn isClubs(self: Suit) bool {
        return self == Suit.Clubs;
    }

    pub fn isDiamonds(self: Suit) bool {
        return self == Suit.Diamonds;
    }

    pub fn isHearts(self: Suit) bool {
        return self == Suit.Hearts;
    }

    pub fn isSpades(self: Suit) bool {
        return self == Suit.Spades;
    }
};

test "enum functions" {
    var suit = Suit.Diamonds;
    assert(suit.isDiamonds());
    assert(Suit.isDiamonds(suit)); // ufcs
    assert(!suit.isClubs());
}

// enums are amenable to switch
const Foo = enum {
    String,
    Number,
    None,
};

test "switch with enums" {
    const p = Foo.Number;

    var what_is_it = switch (p) {
        .String => "a string",
        .Number => "a number",
        .None => "something else",
    };

    assert(std.mem.eql(u8, what_is_it, "a number"));
}

// access the tag type of an enum using @TagType
test "@TagType" {
    comptime {
        assert(@TagType(Suit) == u2);
        assert(@TagType(Foo) == u2);
        assert(@TagType(Value) == u2);
        assert(@TagType(Value2) == u32);
    }
}

test "@tagName" {
    assert(std.mem.eql(u8, @tagName(Suit.Diamonds), "Diamonds"));
    assert(std.mem.eql(u8, @tagName(Foo.String), "String"));
    assert(std.mem.eql(u8, @tagName(Value2.Million), "Million"));
}

test "@typeInfo" {
    assert(@typeInfo(Suit).Enum.fields.len == 4);
    assert(std.mem.eql(u8, @typeInfo(Suit).Enum.fields[1].name, "Diamonds"));

    warn("{}\n", .{@typeInfo(Suit)});
}
