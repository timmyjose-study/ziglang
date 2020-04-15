test "undefined behaviour - index out of bounds" {
    comptime {
        const array: [5]u8 = "hello".*;
        const _garbage = array[5];
    }
}
