/**
 * @file   FileOutputStream.h
 * @Author Mafahir Fairoze
 * @date   2/6/17
 *
 * Copyright © 2017-2019 V-Key. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>
/**
 * @brief File stream class using AES-XTS to write to encrypted files.
 */
@interface FileOutputStream : NSObject
/**
 * @brief Initialize FileOutputStream with \p fileName and \p password.
 * @param[in] fileName The file path.
 * @param[in] password The password (optional) to secure the file. If provided, it must be a valid password.
 * A valid password must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 * @return The FileOutputStream instance.
 */
- (id) initWithFileName:(NSString *)fileName
               password:(NSString *)password;

/**
 * @brief Initialize FileOutputStream with \p fileName, \p password, and whether to \p append the file.
 * @param[in] fileName The file path.
 * @param[in] password The password (optional) to secure the file. If provided, it must be a valid password.
 * A valid password must contain:
 * @li at least one digit
 * @li at least one lowercase character
 * @li at least one uppercase character
 * @li at least one symbols from !@#$%^&
 * @li at least with a length of 6 up to a maximum of 20
 * @param[in] append If `true` the file will be appended or truncated.
 * @return The FileOutputStream instance.
 */
- (id) initWithFileName:(NSString *)fileName
               password:(NSString *)password
                 append:(bool)append;

/**
 * @brief Check if more data is available for writing.
 * @return `true` if more data is available for writing. Else, `false`.
 */
- (bool) available;

/**
 * @brief Close and flush the stream.
 */
- (void) close;

/**
 * @brief Write a byte to file.
 * @param[in] byte The encrypted byte to write.
 */
- (void) writeByte:(uint8_t)byte;

/**
 * @brief Encrypt and write data to stream using XTS mode.
 * @param[in] buffer The buffer to write.
 * @param[in] len The number of bytes to write
 */
- (void) writeBytes:(const uint8_t *)buffer
             length:(uint32_t)len;

/**
 * @brief Change the current position in the file to the given \p off offset.
 * @param[in] off The offset in number of bytes from the up to of the file.
 */
- (void) seekToOffset:(int64_t) pos;

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
