#ifndef FLOAT_STRICT_OPTIMIZED_H
#define FLOAT_STRICT_OPTIMIZED_H

#include <stdint.h>

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

double foo_strict(double x);
double foo_optimized(double x);

#ifdef __cplusplus
} // extern "C"
#endif

extern struct mach_header_64 _mh_execute_header;

#endif // FLOAT_STRICT_OPTIMIZED_H
