test "undefined behaviour - casting a large number, attempting to truncate data" {
    const spartan_count = 300;
    const byte = @intCast(u8, spartan_count);
}
