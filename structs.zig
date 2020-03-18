const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

const Point = struct {
    x: f32,
    y: f32,
};

test "basic structs" {
    const origin = Point{ .x = 0.0, .y = 0.0 };
    assert(origin.x == 0.0);
    assert(origin.y == 0.0);
}

// gives guarantees about memory layout
const Point2 = packed struct {
    x: f32,
    y: f32,
};

test "packed struct" {
    const point = Point2{ .x = 0.12, .y = -1.23 };
    assert(point.x == 0.12);
    assert(point.y == -1.23);
}

// structs can have methods
const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vec3 {
        return Vec3{
            .x = x,
            .y = y,
            .z = z,
        };
    }

    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }
};

test "structs with methods" {
    const v = Vec3.init(1.0, -2.0, 3.0);
    assert(v.x == 1.0);
    assert(v.y == -2.0);
    assert(v.z == 3.0);
    warn("dot(v) = {}\n", .{v.dot(v)});
    warn("dot(v) = {}\n", .{Vec3.dot(v, v)});
}

// structs can also be used as namespaces
const Empty = struct {
    pub const PI = 3.14159;
};

test "structs as namespaces" {
    assert(@sizeOf(Empty) == 0);
    const radius = 10.0;
    const area = Empty.PI * radius * radius;
    warn("area of a circle with radius {} = {}\n", .{ @floatCast(f64, radius), @floatCast(f64, area) });
}

// struct fields order is determined by the compiler for performance reasons, but given a pointer to a field,
// one can still calculate the base pointer to the struct.
fn setYBasedOnX(x: *f32, y: f32) void {
    const base_ptr = @fieldParentPtr(Point, "x", x);
    base_ptr.y = y;
}

test "@fieldParentPtr" {
    var point = Point{ .x = 1.23, .y = undefined };
    setYBasedOnX(&point.x, -3.12);
    assert(point.x == 1.23);
    assert(point.y == -3.12);
}

// generics in Zig
fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            data: T,
            prev: ?*Node,
            next: ?*Node,
        };

        first: ?*Node,
        last: ?*Node,
        len: usize,
    };
}

test "generics" {
    // functions called at comptime are memoized
    assert(LinkedList(i32) == LinkedList(i32));

    var list = LinkedList(i32){
        .first = null,
        .last = null,
        .len = 0,
    };

    assert(list.len == 0);

    // types are first-class in Zig
    const ListOfInts = LinkedList(i32);
    var ll = ListOfInts{
        .first = null,
        .last = null,
        .len = 0,
    };

    var node = ListOfInts.Node{
        .data = 12345,
        .prev = null,
        .next = null,
    };

    ll.first = &node;
    ll.last = &node;
    ll.len = 1;

    assert(ll.len == 1);
    assert(ll.first.?.data == 12345);
    assert(ll.last.?.data == 12345);
}
