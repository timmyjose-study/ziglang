#ifndef EXTERN_ENUM_H
#define EXTERN_ENUM_H

#include <stdint.h>

enum Foo {
    A = 0,
    B = 1,
    C = 2
};

struct mach_header_64 {
    uint32_t magic;
    int cputype;
    int cpusubtype;
    uint32_t filetype;
    uint32_t ncmds;
    uint32_t sizeofcmds;
    uint32_t flags;
    uint32_t reserved;
};

#ifdef __cplusplus
extern "C" {
#endif

void entry(enum Foo foo);

#ifdef __cplusplus
} // extern "C"
#endif

extern struct mach_header_64 _mh_execute_header;

#endif // EXTERN_ENUM_H
