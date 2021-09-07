/**
 * @file   SecureData.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 * Copyright © 2017 V-Key. All rights reserved.
 *
 */
#pragma once
#include "Commons.h"

namespace securefileio { namespace core {


    /**
     * @brief   Class for handling secure data.
     */
    class SecureData {
        SecureData() = delete;
    public:
        /**
         * @brief   Class for Secure Data Utilities.
         */
        class Utility {
            Utility() = delete;
        public:
            /**
             * @brief   Check if upgrade is needed for the \p input data.
             * @param[in]   input   The input data.
             * @param[in]   len     The length.
             * @return `true` if upgrade is needed. Else, `false`.
             */
            SFIO_API static bool isUpgradeDataNeeded(const void *input, uint_t len);

            /**
             * @brief   Upgrade the \p input data.
             *
             * @param[in]   input      The encrypted input data.
             * @param[in]   len        The length of input data.
             * @param[in]   output     The upgraded data.
             * @param[in]   outputLen  The length of output data.
             * @return length of the data that would have been copied onto \p output if \p outputLen was sufficiently large enough and \p output is not 'null'
             */
            SFIO_API static uint_t UpgradeData(const void *input, uint_t len, void *output, uint_t outputLen);
        };
    	/**
    	 * @brief  Encrypt \p input plain data of \p len into \p output and set \p outputLen.
    	 *
    	 * @param[in]  input      The input plain data.
    	 * @param[in]  len        The length of input data.
    	 * @param[in]  output     The output encrypted data.
    	 * @param[in]  outputLen  The length of output data.
         * @return length of the data that would have been copied onto \p output if \p outputLen was sufficiently large enough and \p output is not 'null'
    	 */
        SFIO_API static uint_t encrypt(const void *input, uint_t len, void *output, uint_t outputLen);

        /**
         * @brief   Decrypt \p input cipher data of \p len into \p output and set \p outputLen.
         *
         * @param[in]  input      The input ciper data.
         * @param[in]  len        The length of input data.
         * @param[in]  output     The output decrypted data.
         * @param[in]  outputLen  The length of output data.
         * @return length of the data that would have been copied onto \p output if \p outputLen was sufficiently large enough and \p output is not 'null'
         */
        SFIO_API static uint_t decrypt(const void *input, uint_t len, void *output, uint_t outputLen);
    };
}}
