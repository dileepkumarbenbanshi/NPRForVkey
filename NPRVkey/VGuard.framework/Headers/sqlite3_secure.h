/**
 * @file   sqlite3_secure.h
 * @Author Mafahir Fairoze
 * @date   9/6/17
 *
 * Copyright © 2017-2019 V-Key. All rights reserved.
 *
 */

#pragma once
#include "sqlite3.h"

#define SFIO_API  __attribute__ ((visibility ("default")))


#ifdef __cplusplus
extern "C" {  /* begining of the 'extern "C"' block */
#endif

    /**
     * Opens an encrypted DB instance.
     *
     * @param filename Database filename (UTF-8)
     * @param ppDb SQLite db handle
     * @return SQLITE_OK if successful
     */
    SFIO_API int sqlite3_open_secure(
                            const char *filename,
                            sqlite3 **ppDb
                            );

    /**
     * Opens an encrypted DB instance.
     *
     * @param filename Database filename (UTF-8)
     * @param ppDb SQLite db handle
     * @param flags file open options
     * @param zVfs (not supported, use NULL instead)
     * @return SQLITE_OK if successful
     */
    SFIO_API int sqlite3_open_secure_v2(
                               const char *filename,
                               sqlite3 **ppDb,
                               int flags,
                               const char *zVfs
                               );

   /**
    * From SFIO retrieve the last error message that occured in the current thread
    *
    * @return the error message, empty string if none.
    */
    SFIO_API const char * sqlite3_get_last_error_message();

#ifdef __cplusplus
}  /* end of the 'extern "C"' block */
#endif
