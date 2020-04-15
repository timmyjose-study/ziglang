comptime {
    assert(false);
}

fn assert(ok: bool) void {
    if (!ok) unreachable;
}
