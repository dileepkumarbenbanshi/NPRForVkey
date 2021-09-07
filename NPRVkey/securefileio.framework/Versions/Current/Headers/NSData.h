//
//  NSData.h
//  VGuard
//
//  Created by Hong Nhat Pham on 2/10/13.
//  Copyright (c) 2013 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

__deprecated_msg("This class has been deprecated in version 4.6 and will be removed in the next version")
__attribute__((visibility("default")))
@interface VOSSecureFileIO_DataWrapper : NSObject
+ (NSData*)dataWithContentsOfFile:(NSString *)path;
+ (BOOL)writeData:(NSData*)data toFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
+ (BOOL)writeData:(NSData*)data toFile:(NSString *)path options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)error;
@end
