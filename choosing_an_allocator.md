# How to choose the proper memory allocator for a task?

1. If making a library, have the API declare a `*Allocator` parameter, leaving the choice of the appropriate allocator to the user.

2. If linking with libc, use `std.heap.c_allocator`.

3. If the maximum amount of required heap memory is known at comptime, use either `std.heap.FixedBufferAllocator` or `std.heap.ThreadSafeFixedBufferAllocator`.

4. If it is a CLI or a cyclical application (such as a video game loop/webserver) use `std.heap.ArenaAllocator`. Use `std.heap.FixedBufferAllocator` as a further
   optimisation if the upper bound of memory usage can be established. Arena allocators allow us to allocate a chunk of memory in one go, and to free it
   in one go at the end of the program's lifecycle.

5. If writing tests (and we wish to ensure that OOM errors are handled properly), use `std.testing.FailingAllocator`.

6. Finally, if none of the above is applicable, either use `std.heap.default_allocator` (the general purpose allocator), or implement your own allocator
   which conforms to the standard `Allocator` interface.

