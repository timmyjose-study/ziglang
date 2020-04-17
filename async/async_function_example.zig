const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const warn = std.debug.warn;

pub fn main() void {
    _ = async amainWrap();

    resume global_file_frame;
    resume global_download_frame;
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

fn amain() !void {
    const allocator = std.heap.page_allocator;
    var download_frame = async fetchUrl(allocator, "https://www.example.com");
    var awaited_download_frame = false;
    errdefer if (!awaited_download_frame) {
        if (await download_frame) |r| allocator.free(r) else |_| {}
    };

    var file_frame = async readFile(allocator, "something.txt");
    var awaited_file_frame = false;
    errdefer if (!awaited_file_frame) {
        if (await file_frame) |r| allocator.free(r) else |_| {}
    };

    awaited_file_frame = true;
    const file_text = try await file_frame;
    defer allocator.free(file_text);

    awaited_download_frame = true;
    const download_text = try await download_frame;
    defer allocator.free(download_text);

    warn("Downloaded text: {}\n", .{download_text});
    warn("File text: {}\n", .{file_text});
}

var global_download_frame: anyframe = undefined;
fn fetchUrl(allocator: *Allocator, url: []const u8) ![]u8 {
    const result = try std.mem.dupe(allocator, u8, "these are the downloaded url contents");
    errdefer allocator.free(result);
    suspend {
        global_download_frame = @frame();
    }
    warn("fetchUrl returning...\n", .{});
    return result;
}

var global_file_frame: anyframe = undefined;
fn readFile(allocator: *Allocator, file: []const u8) ![]u8 {
    const result = try std.mem.dupe(allocator, u8, "this are the file contents");
    errdefer allocator.free(result);
    suspend {
        global_file_frame = @frame();
    }
    warn("readFile returning...\n", .{});
    return result;
}
