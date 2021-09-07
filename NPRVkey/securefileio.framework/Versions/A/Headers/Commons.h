/**
 * @file   Commons.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 *   Copyright © 2017 V-Key. All rights reserved.
 *
 */
#pragma once
#include <stdint.h>
#include <string>
#include <limits>
#include <vector>
#include <memory>

#define SFIO_API  __attribute__ ((visibility ("default")))

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)

namespace securefileio { namespace core {
    
    typedef uint8_t byte_t;
    typedef std::numeric_limits<byte_t> byte_limit;
    
    typedef uint16_t ushort_t;
    typedef std::numeric_limits<ushort_t> ushort_limit;
    
    typedef int16_t short_t;
    typedef std::numeric_limits<short_t> short_limit;
    
    typedef uint32_t uint_t;
    typedef std::numeric_limits<uint_t> uint_limit;
    
    typedef int32_t int_t;
    typedef std::numeric_limits<int_t> int_limit;
    
    typedef int64_t long_t;
    typedef std::numeric_limits<long_t> long_limit;
    
    typedef uint64_t ulong_t;
    typedef std::numeric_limits<ulong_t> ulong_limit;
    
    typedef std::string string_t;

}}
