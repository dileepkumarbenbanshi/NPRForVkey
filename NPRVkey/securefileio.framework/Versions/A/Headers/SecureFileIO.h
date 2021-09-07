/**
 * @file   SecureFileIO.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 * Copyright © 2017-2019 V-Key. All rights reserved.
 *
 */

#pragma once
#import <Foundation/Foundation.h>

/**
 * @brief Utility class for byte and file encryption.
 */
@interface SecureFileIO : NSObject

/**
 * @brief   Encrypt data using CBC mode.
 *
 * @param[in]   data The data to be encrypted.
 * @return      The encrypted data.
 */
+ (NSData *) encryptData:(NSData *)data;

/**
 * @brief   Encrypt data to file using XTS mode.
 *
 * @param[in] data      The data to be encrypted into a file.
 * @param[in] path      The path to the output encrypted file.
 * @param[in] password  The password (optional). If provided, it must be a valid password.
 * A valid password, must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 * @param useAuxiliaryFile Whether to write to a temporary file before reflecting changes to path. Set to `YES` or `NO`.
 */
+ (void) encryptData:(NSData*)data
              toFile:(NSString *)path
            password:(NSString *)password
          atomically:(BOOL)useAuxiliaryFile;

/**
 * @brief Decrypt data using CBC mode.
 *
 * @param[in] cipher The ciper to be decrypted.
 * @return The decrypted data.
 */
+ (NSData *) decryptData:(NSData *)cipher;

/**
 * @brief Encrypt string to file using XTS mode.
 *
 * @param[in]   str         The string to be encrypted into a file.
 * @param[in]   path        The path to the output encrypted file.
 * @param[in]   password    The password (optional). If provided, it must be a valid password.
 * A valid password, must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 *
 * @param useAuxiliaryFile if 'yes' would write to a temporary file before reflecting changes to path
 */
+ (void) encryptString:(NSString*)str
                toFile:(NSString *)path
              password:(NSString *)password
            atomically:(BOOL)useAuxiliaryFile;

/**
 * @brief Using XTS mode to decrypt a file and converted to string format
 *
 * @param[in]   path        The path to the encrypted file.
 * @param[in]   password    The password (optional). If provided, it must be a valid password.
 * A valid password, must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 *
 * @return The decrypted string.
 */
+ (NSString *) decryptStringFromFile:(NSString *)path
                            password:(NSString *)password;

/**
 * @brief   Decrypt a file at given path using XTS mode.
 *
 * @param[in]   path        The path to the encrypted file.
 * @param[in]  password     The password (optional). If provided, it must be a valid password.
 * A valid password, must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 *
 * @return The decrypted file as byte array.
 */
+ (NSData *) decryptFile:(NSString *)path
                password:(NSString *)password;

/**
 * @brief   Update the a file at \p path from \p oldPassword to \p newPassword.
 *
 * @param[in]  path         The file path.
 * @param[in]  newPassword  The new password.
 * @param[in]  oldPassword  The old password.
 */
+ (void) updateFile:(NSString *)path
         newPassword:(NSString *)newPassword
         oldPassword:(NSString *)oldPassword;

/**
 * @brief      Checks if upgrade is needed
 * @param[in] data to be encrypted
 * @return if upgrade is needed
 */
+ (bool) isUpgradeDataNeeded:(NSData *)data;

/**
 * @brief      Upgrade the data
 *
 * @param[in]  data      The encrypted input
 * @return upgraded data, nil if not necessary or failure to upgrade.
 */
+ (NSData *) UpgradeData:(NSData *)data;

/**
 * @brief   Check if a file at \p path needs to be upgraded.
 *
 * @param[in]  path         The file path.
 * @param[in]  password     The password.
 *
 * @return     `true` if upgrade is needed.
 */
+ (bool) isUpgradeFileNeeded:(NSString*) path
                    password:(NSString*) password;

/**
 * @brief   Upgrade header of file at \p path with update from \p oldPassword to \p newPassword.
 *
 * @param[in]  path         The file path.
 * @param[in]  newPassword  The new password.
 * @param[in]  oldPassword  The old password.
 *
 * @return  `true` if upgrade is successful.
 */
+ (bool) upgradeFile:(NSString *)path
        newPassword:(NSString *)newPassword
        oldPassword:(NSString *)oldPassword;



/**
 * @brief   Upgrade/update header of file \p from one path and save it \p to another path with update from \p oldPassword to \p newPassword.
 *
 * @param[in]  from         The source path.
 * @param[in]  to           The destination path.
 * @param[in]  newPassword  The new password.
 * @param[in]  oldPassword  The old password.
 *
 * @return     `true` if upgrade is successful.
 */
+ (bool) upgradeFileFrom:(NSString *)from
                      to:(NSString *)to
             newPassword:(NSString *)newPassword
             oldPassword:(NSString *)oldPassword;

/**
 * @brief      Encrypt a file at \p path with \p newPassword.
 *
 * @param[in]  path         The file path.
 * @param[in]  newPassword  The new password.
 */
+ (void) encryptFile:(NSString *)path
         newPassword:(NSString *)newPassword;

/**
 * @brief      Encrypt a file \p from one path and save it \p to another path with \p newPassword.
 *
 * @param[in]  from         The source path.
 * @param[in]  to           The destination path.
 * @param[in]  newPassword  The new password.
 */
+ (void) encryptFileFrom:(NSString *)from
                      to:(NSString *)to
             newPassword:(NSString *)newPassword;

@end
