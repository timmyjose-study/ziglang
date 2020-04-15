const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

// Demonstrating here how the comptime semantics do not necessarily require any annotation
// on the function itself

fn fibonacci(index: u32) u32 {
    if (index < 2) {
        return index;
    } else {
        return fibonacci(index - 1) + fibonacci(index - 2);
    }
}

test "fibonacci" {
    assert(fibonacci(7) == 13);
    comptime {
        assert(fibonacci(7) == 13);
    }
}

fn factorial(n: u32) u32 {
    if (n < 2) {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

test "factorial" {
    assert(factorial(10) == 3628800);
    comptime assert(factorial(5) == 120);
}

// in the global scope, all expressions are implicitly comptime - this means that complex initialisations can be done in the global scope itself

const first_25_primes = firstNPrimes(25);
const sum_of_first_25_primes = sum(&first_25_primes);

fn sum(numbers: []const i32) i32 {
    var result: i32 = 0;

    for (numbers) |n| {
        result += n;
    }

    return result;
}

fn firstNPrimes(comptime n: usize) [n]i32 {
    var prime_list: [n]i32 = undefined;
    var next_index: usize = 0;
    var test_number: i32 = 2;

    while (next_index < prime_list.len) : (test_number += 1) {
        var test_prime_index: usize = 0;
        var is_prime = true;
        while (test_prime_index < next_index) : (test_prime_index += 1) {
            if (@rem(test_number, prime_list[test_prime_index]) == 0) {
                is_prime = false;
                break;
            }
        }

        if (is_prime) {
            prime_list[next_index] = test_number;
            next_index += 1;
        }
    }

    return prime_list;
}

test "global scope comptime initialisations" {
    assert(sum_of_first_25_primes == 1060);

    warn("\nThe first 100 primes are as follows...\n", .{});
    const first_100_primes = firstNPrimes(100);
    for (first_100_primes) |p| {
        warn("{} ", .{p});
    }
    warn("\n", .{});
}
