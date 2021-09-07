/**
 * @file   FileInputStream.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 * Copyright © 2017-2019 V-Key. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>
/**
 * @brief File stream class using AES-XTS to read from encrypted files.
 */
@interface FileInputStream : NSObject
/**
 * @brief Initialize FileInputStream with \p fileName and \p password.
 * @param[in] fileName The path to the encrypted file.
 * @param[in] password The password (optional) to secure the file. If provided, it must be a valid password.
 * A valid password must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 * @return The FileInputStream instance.
 */
- (id) initWithFileName:(NSString *)fileName
               password:(NSString *)password;

/**
 * @brief Check if more data is available for reading.
 * @return `true` if more data is available for reading. Else, `false`.
 */
- (bool) available;

/**
 * @brief Close and flush the stream.
 */
- (void) close;

/**
 * @brief Decrypt a byte.
 * @return A decrypted byte.
 */
- (uint8_t) read;

/**
 * @brief Decrypt and read data from stream into \p buffer with the maximum \p len of bytes to read.
 * @param[out] buffer The output buffer.
 * @param[in] len The maximum count of bytes to read.
 * @return The actual number of bytes read.
 */
- (int32_t) readBytes:(uint8_t *)buffer
               length:(uint32_t)len;

/**
 * @brief Skip the \p n number of bytes from the current position.
 * @param[in] n The number of bytes to skip.
 */
- (void) skipBytes:(int64_t)n;

/**
 * @brief Change the current position in the file to the given offset \p off.
 * @param[in] off The offset in number of bytes from the beginning of the file.
 */
- (void) seekToOffset:(int64_t)off;

/**
 * @brief Get the size of the current file.
 * @return The size of current file.
 */
- (int64_t) size;

/**
 * @brief Get the position of the current file.
 * @return The current file position.
 */
- (int64_t) position;
@end
