//
//  NSString.h
//  VGuard
//
//  Created by Hong Nhat Pham on 2/10/13.
//  Copyright (c) 2013 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

__deprecated_msg("This class has been deprecated in version 4.6 and will be removed in the next version")
__attribute__((visibility("default")))
@interface VOSSecureFileIO_StringWrapper : NSObject
+ (NSString*)stringWithContentsOfFile:(NSString *)path
                             encoding:(NSStringEncoding)enc
                                error:(NSError **)error;
+ (NSString*)stringWithContentsOfFile:(NSString *)path
                             usedEncoding:(NSStringEncoding*)enc
                                error:(NSError **)error;
+ (BOOL)writeString:(NSString*)str
             toFile:(NSString *)path
         atomically:(BOOL)useAuxiliaryFile;
+ (BOOL)writeString:(NSString*)str
             toFile:(NSString *)path
         atomically:(BOOL)useAuxiliaryFile
           encoding:(NSStringEncoding)enc
              error:(NSError **)error;
@end
