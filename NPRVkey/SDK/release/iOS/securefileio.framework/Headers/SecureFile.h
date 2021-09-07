/**
 * @file   SecureFile.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 * Copyright © 2017-2019 V-Key. All rights reserved.
 *
 */
#pragma once
#include "Commons.h"

namespace securefileio { namespace core {

    class FileInfo;

    /**
     * @brief   Class for handling secure file.
     */
    class SecureFile {
    public:
        /**
         * @brief   Class for Secure File Utilities.
         */
        class Utility {
            Utility() = delete;
        public:
            /**
             * @brief      Update the a \p file from \p oldPassword to \p newPassword.
             *
             * @param[in]  file         The file path.
             * @param[in]  newPassword  The new password.
             * @param[in]  oldPassword  The old password.
             */
            SFIO_API static void UpdateFile(string_t file, string_t newPassword, string_t oldPassword = "");

            /**
             * @brief      Check if a \p file needs to be upgraded.
             *
             * @param[in]  file         The file path.
             * @param[in]  password     The password.
             *
             * @return     `true` if upgrade is needed.
             */
            SFIO_API static bool isUpgradeFileNeeded(string_t file, string_t password = "");

            /**
             * @brief      Upgrade header of \p file with update from \p oldPassword to \p newPassword.
             *
             * @param[in]  file         The file path.
             * @param[in]  newPassword  The new password.
             * @param[in]  oldPassword  The old password.
             *
             * @return     `true` if upgrade is successful.
             */
            SFIO_API static bool UpgradeFile(string_t file, string_t newPassword = "", string_t oldPassword = "");

            /**
             * @brief      Upgrade/update header of file \p from one path and save it \p to another path with update from \p oldPassword to \p newPassword.
             *
             * @param[in]  from         The source path.
             * @param[in]  to           The destination path.
             * @param[in]  newPassword  The new password.
             * @param[in]  oldPassword  The old password.
             *
             * @return     `true` if upgrade is successful.
             */
            SFIO_API static bool UpgradeFile(string_t from, string_t to, string_t newPassword, string_t oldPassword);

            /**
             * @brief      Encrypt a \p file with \p newPassword.
             *
             * @param[in]  file         The file path.
             * @param[in]  newPassword  The new password.
             */
            SFIO_API static void EncryptFile(string_t file, string_t newPassword = "");

            /**
             * @brief      Encrypt a file \p from one path and save it \p to another path with \p newPassword.
             *
             * @param[in]  from         The source path.
             * @param[in]  to           The destination path.
             * @param[in]  newPassword  The new password.
             */
            SFIO_API static void EncryptFile(string_t from, string_t to, string_t newPassword);
        private:
            struct Impl;
        };

        /**
         * @brief      Construct an instance to Secure File with \p file, \p password, \p flags, and \p mode.
         *
         * @param[in]  file      The file path.
         * @param[in]  password  The password (optional) to secure the file. If provided, it must be a valid password.
         * A valid password must contain:
         * @li at least one digit
         * @li at least one lowercase character
         * @li at least one uppercase character
         * @li at least one symbols from !@#$%^&
         * @li at least with a length of 6 upto a maximum of 20
         *
         * @param[in]  flags     The open flags.
         * @param[in]  mode      The file permission.
         */
        SFIO_API SecureFile(string_t file, string_t password, int_t flags, int_t mode, bool forceUpgradeFile = true);

        /**
         * @brief      Construct an instance to Secure File with \p file, \p flags, and \p mode.
         *
         * @param[in]  file      The file path.
         * @param[in]  flags     The open flags.
         * @param[in]  mode      The file permission.
         */
        SFIO_API SecureFile(string_t file, int_t flags, int_t mode, bool forceUpgradeFile = true);

        /**
         * @brief      Construct an instance to Secure File with \p file, \p password, and \p flags.
         *
         * @param[in]  file      The file path.
         * @param[in]  password  The password (optional) to secure the file. If provided, it must be a valid password.
         * A valid password must contain:
         * @li at least one digit
         * @li at least one lowercase character
         * @li at least one uppercase character
         * @li at least one symbols from !@#$%^&
         * @li at least with a length of 6 upto a maximum of 20
         *
         * @param[in]  flags     The open flags.
         */
        SFIO_API SecureFile(string_t file, string_t password, int_t flags);

        /**
         * @brief      Construct an instance to Secure File.
         *
         * @param[in]  file      The file path.
         * @param[in]  flags     The open flags.
         */
        SFIO_API SecureFile(string_t file, int_t flags);


        /**
         * @brief      Construct an instance to Secure File with \p file and \p password.
         *
         * @param[in]  file      The file path.
         * @param[in]  password  The password (optional) to secure the file. If provided, it must be a valid password.
         * A valid password must contain:
         * @li at least one digit
         * @li at least one lowercase character
         * @li at least one uppercase character
         * @li at least one symbols from !@#$%^&
         * @li at least with a length of 6 upto a maximum of 20
         */
        SFIO_API SecureFile(string_t file, string_t password = "");

        /**
         * @brief      Destroys the object.
         */
        ~SecureFile();

        /**
         * @brief      Close the file.
         */
        SFIO_API void close();

        /**
         * @brief      Read from file into \p buf with \p len.
         *
         * @param      buf   The buffer.
         * @param[in]  len   The length.
         *
         * @return     The amount actually read. -1 if end of file.
         */
        SFIO_API int_t read(void *buf, uint_t len);

        /**
         * @brief      Write to file from \p buf with \p len.
         *
         * @param[in]  buf   The buffer.
         * @param[in]  len   The length.
         *
         * @return     The amount actually written.
         */
        SFIO_API int_t write(const void *buf, uint_t len);

        /**
         * @brief      Get the size of file.
         *
         * @return     The size of file.
         */
        SFIO_API long_t size() const;

        /**
         * @brief      Set the size of file.
         * If size is less than current size, file will be truncated, else file will be filled with zero.
         * File cursor position will not be changed.
         *
         * @param[in]  size  The new file size.
         */
        SFIO_API void setSize(long_t size);

        /**
         * @brief      Get the file cursor position.
         *
         * @return     The cursor position.
         */
        SFIO_API long_t position() const;

        /**
         * @brief      Seek to \p off offset in file. Offset is calculated from begining of file.
         *
         * @param[in]  off   The offset.
         */
        SFIO_API void seek(long_t off);

        /**
         * @brief      Skip \p n bytes from current position.
         *
         * @param[in]  n     Number of bytes to skip.
         */
        SFIO_API void skip(long_t n);

    private:
        struct Impl;
        std::unique_ptr<Impl> _impl;
    };

}}
