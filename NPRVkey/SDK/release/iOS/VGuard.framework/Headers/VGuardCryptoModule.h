//
//  VGuardCryptoModule.h
//  VGuard
//
//  Created by Chinwee Koh on 14/5/13.
//  Copyright (c) 2013 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "vosInterfaceConst.h"
#import "VosWrapper.h"

@interface VGuardCryptoModule : NSObject

// AES
+ (NSData*)VGuardAESEncryption:(NSData*)rawData key:(NSData*)key iv:(NSData*)iv mode:(CipherMode)mode error:(VosError**)errorPtr;
+ (NSData*)VGuardAESDecryption:(NSData*)rawData key:(NSData*)key iv:(NSData*)iv mode:(CipherMode)mode error:(VosError**)errorPtr;
+ (NSData*)VGuardAESEncryption:(NSData*)rawData withKeyAlias:(int)keyAlias iv:(NSData *)iv mode:(CipherMode)mode error:(VosError**)errorPtr;
+ (NSData*)VGuardAESDecryption:(NSData*)rawData withKeyAlias:(int)keyAlias iv:(NSData *)iv mode:(CipherMode)mode error:(VosError**)errorPtr;

// 3DES
+ (NSData*)VGuardDes3Encryption:(NSData*)rawData withKey:(NSData*)key iv:(NSData*)iv error:(VosError**)errorPtr;
+ (NSData*)VGuardDes3Decryption:(NSData*)rawData withKey:(NSData*)key iv:(NSData*)iv error:(VosError**)errorPtr;
+ (NSData*)VGuardDes3Encryption:(NSData*)rawData withKeyAlias:(int)keyAlias iv:(NSData*)iv error:(VosError**)errorPtr;
+ (NSData*)VGuardDes3Decryption:(NSData*)rawData withKeyAlias:(int)keyAlias iv:(NSData*)iv error:(VosError**)errorPtr;

// Key Store
+(int)VGuardLoadKeyStore:(NSData*)keyData withPassword:(NSString*)pwd;
+(NSData*)VGuardSaveKeyStore:(NSString*)pwd error:(VosError**)errorPtr;
+(int)VGuardClearKeyStore;
+(int)VGuardKeyStoreCount;
+(int)VGuardIsKeyInKeyStore:(int)keyAlias;
+(int)VGuardSetKey:(NSData*)key withAlias:(int)keyAlias algo:(Algorithm)algo type:(TypeOfKey)keyType;
+(int)VGuardGenerateSymmetricKeyInStore:(int)keySize alias:(int)keyAlias algo:(Algorithm)algo;
+(int)VGuardDelKey:(int)keyAlias;
+(int)VGuardSetRSAPrivKey:(NSData*)n pubExp:(NSData*)e privExp:(NSData*)d prime1:(NSData*)p prime2:(NSData*)q exp1:(NSData*)dp exp2:(NSData*)dq coef:(NSData*)u alias:(int)keyAlias;
+(int)VGuardSetRSAPubKey:(NSData*)n pubExp:(NSData*)e alias:(int)keyAlias;
+(int)VGuardRSAPrivKeyWithAlias:(int)keyAlias n:(NSData *__autoreleasing *)n
                         e:(NSData *__autoreleasing *)e
                         d:(NSData *__autoreleasing *)d;
+(int)VGuardRSAPrimeNumWithAlias:(int)keyAlias p:(NSData *__autoreleasing *)p
                          q:(NSData *__autoreleasing *)q;

// RSA
+(NSData *)VGuardRSAPrivKeyDecrypt:(NSData*)data keyAlias:(int)key error:(VosError**)errorPtr;
+(NSData *)VGuardRSAPubKeyEncrypt:(NSData*)data keyAlias:(int)key error:(VosError**)errorPtr;
+(NSData*)VGuardRSASha1Sign:(NSData*)inputData withKeyAlias:(int)keyAlias error:(VosError**)errorPtr;
+(int)VGuardRSASha1Verify:(NSData*)inputData signature:(NSData*)signedData withKeyAlias:(int)keyAlias;
+(NSData*)VGuardRSASha256Sign:(NSData*)inputData withKeyAlias:(int)keyAlias error:(VosError**)errorPtr;
+(int)VGuardRSASha256Verify:(NSData*)inputData signature:(NSData*)signedData withKeyAlias:(int)keyAlias;
+(NSData*)VGuardRSAOAEPEncrypt:(NSData*)inputData withKeyAlias:(int)keyAlias param:(NSData*)param plen:(int)plen error:(VosError**)errorPtr;
+(NSData*)VGuardRSAOAEPDecrypt:(NSData*)inputData withKeyAlias:(int)keyAlias param:(NSData*)param plen:(int)plen error:(VosError**)errorPtr;

// SHA
+(NSData*)VGuardSha1:(NSData*)inputData len:(int)inputDataLength error:(VosError**)errorPtr;
+(NSData*)VGuardSha256:(NSData*)inputData len:(int)inputDataLength error:(VosError**)errorPtr;

// HMAC
+(NSData*)VGuardHmacSha1:(NSData*)message withKey:(NSData*)key resultSize:(int)resultSize error:(VosError**)errorPtr;
+(NSData*)VGuardHmacSha256:(NSData*)message withKey:(NSData*)key resultSize:(int)resultSize error:(VosError**)errorPtr;
+(NSData*)VGuardHmacSha1:(NSData*)message withKeyAlias:(int)keyAlias resultSize:(int)resultSize error:(VosError**)errorPtr;
+(NSData*)VGuardHmacSha256:(NSData*)message withKeyAlias:(int)keyAlias resultSize:(int)resultSize error:(VosError**)errorPtr;

// RNG
+(NSData*)VGuardGenerateRandomBlock:(int)blockLength error:(VosError**)errorPtr;

// KDF
+(NSData*)VGuardKdfHmac:(NSData*)inputMsg withKey:(NSData*)inputKey outputSize:(int)outputSize rLen:(int)rLenBitLength error:(VosError**)errorPtr;
+(NSData*)VGuardKdfHmac:(NSData*)inputMsg withKeyAlias:(int)keyAlias
              outputSize:(int)outputSize rLen:(int)rLenBitLength error:(VosError**)errorPtr;

// PBKDF2
+(NSData*)VGuardPbkdf2:(NSData*)pwd salt:(NSData*)salt iter:(int)rounds outputSize:(int)outputSize error:(VosError**)errorPtr;

@end
