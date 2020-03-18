// just as with structs, plain enums cannot be used with the C ABI - use extern enums instead

const Foo = extern enum {
    A, B, C
};

export fn entry(foo: Foo) void {}
