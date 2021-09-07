/**
 * @file   SecureDatabase.h
 * @Author Mafahir Fairoze
 * @date   9/6/17
 *
 *   Copyright © 2017 Personal. All rights reserved.
 *
 */

#pragma once
#include "sqlite3.h"
#include "Commons.h"

namespace securefileio { namespace core {

    class SecureDatabase {
        SecureDatabase() = delete;
    public:
        /**
         * @brief Opens an encrypted DB instance.
         *
         * @param filename Database filename (UTF-8)
         * @param ppDb SQLite db handle
         * @return SQLITE_OK if successful
         */
        SFIO_API static int Open(const char *filename,
                        sqlite3 **ppDb
                        );

        /**
         * @brief Opens an encrypted DB instance.
         *
         * @param filename Database filename (UTF-8)
         * @param ppDb SQLite db handle
         * @param flags file open options
         * @param zVfs (not supported, use NULL instead)
         * @return SQLITE_OK if successful
         */
        SFIO_API static int Open(const char *filename,
                          sqlite3 **ppDb,
                          int flags,
                          const char *zVfs
                          );

       /**
        * From SFIO retrieve the last error message that occured in the current thread
        *
        * @return the error message, empty string if none.
        */
        SFIO_API static const char * GetLastErrorMessage();
    };
}}
