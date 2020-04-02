const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

test "basic while loop" {
    var counter: u32 = 0;

    while (counter < 10) {
        counter += 1;
        warn("{} ", .{counter});
    }
    warn("\n", .{});
    assert(counter == 10);
}

test "break with while" {
    var counter: u32 = 0;

    while (true) {
        counter += 1;

        if (counter == 10)
            break;
    }

    assert(counter == 10);
}

test "continue with while" {
    var counter: u32 = 0;

    while (true) {
        counter += 1;

        if (counter < 10)
            continue;
        break;
    }

    assert(counter == 10);
}

test "while continue expression" {
    var counter: u32 = 0;

    while (counter < 10) : (counter += 1) {}
    assert(counter == 10);
}

test "while continue expression continued" {
    var i: usize = 1;
    var j: usize = 1;

    while (i * j < 2000) : ({
        i *= 2;
        j *= 3;
    }) {
        const my_ij = i * j;
        assert(my_ij < 2000);
    }
}

test "fibonacci using continue expressions" {
    var a: usize = 0;
    var b: usize = 1;
    var c: usize = a + b;
    var t: usize = undefined;

    var counter: usize = 0;
    while (counter < 8) : ({
        c = a + b;
        a = b;
        b = c;
    }) {
        counter += 1;
    }

    warn("The 10th Fibonacci number is {}\n", .{c});
}

test "while else" {
    var counter: u32 = 0;

    var res = while (counter < 10) {
        counter += 1;
    } else
        counter;

    assert(res == 10);

    assert(rangeHasNumber(1, 10, 2));
    assert(!rangeHasNumber(1, 10, -2));
}

fn rangeHasNumber(start: i32, end: i32, number: i32) bool {
    var idx: i32 = start;
    return while (idx <= end) : (idx += 1) {
        if (idx == number)
            break true;
    } else false;
}
