//
//  SecureFileIO.h
//  VGuard
//
//  Created by Hong Nhat Pham on 23/10/13.
//  Copyright (c) 2013 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

__deprecated_msg("This class has been deprecated in version 4.6 and will be removed in the next version.")
__attribute__((visibility("default")))
@interface VOSSecureFileIO : NSObject

+ (int) initSecureFileIO: (NSData*) pwdArray;
+ (int) version;

//secure data IO

/**
 * @deprecated This function has been deprecated in version 4.6 and will be removed in the next version.
 */
+ (NSData*)dataWithContentsOfFile:(NSString *)path;

/**
 * @deprecated This function has been deprecated in version 4.6 and will be removed in the next version.
 */
+ (BOOL)writeData:(NSData*)data toFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
+ (BOOL)writeData:(NSData*)data toFile:(NSString *)path options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)error;

//secure string's data IO

/**
 * @deprecated This function has been deprecated in version 4.6 and will be removed in the next version.
 */
+ (NSString*)stringWithContentsOfFile:(NSString *)path
                             encoding:(NSStringEncoding)enc
                                error:(NSError **)error;
+ (NSString*)stringWithContentsOfFile:(NSString *)path
                         usedEncoding:(NSStringEncoding*)enc
                                error:(NSError **)error;

/**
 * @deprecated This function has been deprecated in version 4.6 and will be removed in the next version.
 */
+ (BOOL)writeString:(NSString*)str
             toFile:(NSString *)path
         atomically:(BOOL)useAuxiliaryFile;
+ (BOOL)writeString:(NSString*)str
             toFile:(NSString *)path
         atomically:(BOOL)useAuxiliaryFile
           encoding:(NSStringEncoding)enc
              error:(NSError **)error;

@end
