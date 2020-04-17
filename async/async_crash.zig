const std = @import("std");
const warn = std.debug.warn;

var the_frame: anyframe = undefined;

pub fn main() void {
    _ = async amainWrap();
    resume the_frame;
}

fn amainWrap() void {
    amain() catch |err| {
        warn("{}\n", .{err});
        if (@errorReturnTrace()) |trace| {
            std.debug.dumpStackTrace(trace.*);
        }
        std.process.exit(1);
    };
}

fn amain() !void {}
