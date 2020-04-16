const c = @cImport({
    @cInclude("stdio.h");
});

test "simple add using C function" {
    var x: c_int = undefined;
    var y: c_int = undefined;

    _ = c.scanf("%d", &x);
    _ = c.scanf("%d", &y);
    _ = c.printf("%d + %d = %d\n", x, y, x + y);
}
