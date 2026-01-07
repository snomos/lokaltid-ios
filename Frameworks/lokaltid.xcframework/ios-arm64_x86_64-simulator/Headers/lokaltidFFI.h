#ifndef lokaltidFFI_h
#define lokaltidFFI_h

#include <stdint.h>
#include <stdbool.h>

// Buffer for data passing
typedef struct RustBuffer {
    int32_t capacity;
    int32_t len;
    uint8_t *data;
} RustBuffer;

// Call status for error handling
typedef struct RustCallStatus {
    int8_t code;
    RustBuffer errorBuf;
} RustCallStatus;

// Function declarations
RustBuffer uniffi_lokaltid_fn_func_calculate_solar_time_for_location(
    double latitude,
    double longitude,
    int64_t unix_timestamp,
    RustCallStatus *err
);

RustBuffer uniffi_lokaltid_fn_func_calculate_solar_time_now(
    double latitude,
    double longitude,
    RustCallStatus *err
);

// Buffer management
RustBuffer uniffi_lokaltid_fn_clone_rustbuffer(RustBuffer buf, RustCallStatus *err);
void uniffi_lokaltid_fn_free_rustbuffer(RustBuffer buf, RustCallStatus *err);

#endif /* lokaltidFFI_h */
