const std = @import("std");
const assert = std.debug.assert;
const warn = std.debug.warn;

var the_frame: anyframe = undefined;
var final_result: i32 = 0;

test "async function await" {
    seq('a'); // 1
    _ = async amain();
    seq('f'); // 6
    resume the_frame; // goes to f
    seq('i'); // 10
    assert(final_result == 12345);
    assert(std.mem.eql(u8, &seq_points, "abcdefghi"));
    warn("seq_points = {}\n", .{seq_points});
}

fn amain() void {
    seq('b'); // 2
    var f = async another();
    seq('e'); // 5
    final_result = await f; // goes back to amain since this is a suspension point
    seq('h'); // 9, goes back to amain since this function is complete
}

fn another() i32 {
    seq('c'); // 3
    suspend {
        seq('d'); // 4
        the_frame = @frame();
    }
    seq('g'); // 7
    return 12345; // 8
}

var seq_points = [_]u8{0} ** "abcdefghi".len;
var seq_index: usize = 0;

fn seq(c: u8) void {
    seq_points[seq_index] = c;
    seq_index += 1;
}
