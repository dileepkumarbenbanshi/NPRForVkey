//
//  VGConstant.h
//  VGuard
//
//  Created by C-VKEY-1000018 on 14/5/15.
//  Copyright (c) 2015 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const VGuardErrorDomain;

@interface VGConstant : NSObject


typedef NS_ENUM(NSInteger, VGuardErrorCode)
{
    // Firmware Errors

    /**
    * __Cause(s):__
    * The firmware file cannot be found.
    * __Solution(s):__
    * - Make sure that the firmware file is in the `/assets/` folder of your app project
    * - Make sure that the firmware filename is `firmware` without file extension
    */
    VGUARD_ERROR_FIRMWARE_MISSING = 20000,

    /**
    * __Cause(s):__
    * The firmware file is corrupted.
    * __Solution(s):__
    * Replace the firmware file in the `/assets/` folder of your app project with a new copy from V-Key.
    */
    VGUARD_ERROR_FIRMWARE_CORRUPTED = 20001,

    // Profile Errors

    /**
    * __Cause(s):__
    * The profile file cannot be found.
    * __Solution(s):__
    * - Make sure that the profile file is in the `/assets/` folder of your app project
    * - Make sure that the profile filename is `profile` without file extension
    */
    VGUARD_ERROR_PROFILE_MISSING = 20010,

    /**
    * __Cause(s):__
    * The profile file is corrupted.
    * __Solution(s):__
    * Replace the profile file in the `/assets/` folder of your app project with a new copy from V-Key.
    */
    VGUARD_ERROR_PROFILE_CORRUPTED = 20011,

    /**
    * __Cause(s):__
    * The profile file cannot be decrypted.
    * __Solution(s):__
    * Make sure that the profile is encrypted with the correct customer key. To ensure, do the following:
    * - Make sure that the `vkeylicensepack` used is from the matching license used to create the customer on V-OS App Protection Server
    * - Make sure that the profile is downloaded from the correct customer account on V-OS App Protection Server
    */
    VGUARD_ERROR_PROFILE_DECRYPTION = 20012,

    // Signature Errors

    /**
    * __Cause(s):__
    * The signature file cannot be found.
    * __Solution(s):__
    * - Make sure that the signature file is in the `/assets/` folder of your app project
    * - Make sure that the signature filename is `signature` without file extension
    */
    VGUARD_ERROR_SIGNATURE_MISSING = 20020,

    /**
    * __Cause(s):__
    * The profile file is corrupted.
    * __Solution(s):__
    * Replace the signature file in the `/assets/` folder of your app project with a new copy from V-Key.
    */
    VGUARD_ERROR_SIGNATURE_CORRUPTED = 20021,

    /**
    * __Cause(s):__
    * The signature file cannot be decrypted.
    * __Solution(s):__
    * Make sure that the profile is encrypted with the correct key.
    * > Note: Key used to encrypt signature is encrypted by V-OS and stored in the header.
    */
    VGUARD_ERROR_SIGNATURE_DECRYPTION = 20022,

    /**
    * __Cause(s):__
    * The signature file is not valid.
    * __Solution(s):__
    * Signature is platform dependent. Make sure that the signature file is for the correct platform.
    */
    VGUARD_ERROR_SIGNATURE_INVALID = 20023,

    // License, App Signer Errors

    /**
    * __Cause(s):__
    * The `vkeylicensepack` file cannot be found.
    * __Solution(s):__
    *
    * - Make sure that the `vkeylicensepack` file is in the `/assets/` folder of your app project
    * - Make sure that the license pack filename is `vkeylicensepack` without file extension
    */
    VGUARD_ERROR_LICENSE_MISSING = 20030,

    /**
    * __Cause(s):__
    * The `vkeylicensepack` file is corrupted.
    * __Solution(s):__
    * Replace the `vkeylicensepack` file in the `/assets/` folder of your app project with a new copy from V-Key.
    */
    VGUARD_ERROR_LICENSE_CORRUPTED = 20031,

    /**
    * __Cause(s):__
    * The signer certificate used is incorrect.
    * __Solution(s):__
    * - If you are using V-OS debug version, check with V-Key to confirm if the license is generated with a special fixed certificate
    * - If you are not using V-OS debug version, make sure that the app is generated and signed by the correct signer certificate
    * > Note: Request for the license details from V-Key, if necessary.
    */
    VGUARD_ERROR_LICENSE_SIGNER_CERT_MISMATCH = 20032,

    /**
    * __Cause(s):__
    * The license package name is incorrect.
    * __Solution(s):__
    * Make sure that the package name of your app matches the package name given to V-Key during the `vkeylicensepack` generation.
    */
    VGUARD_ERROR_LICENSE_PACKAGE_NAME_MISMATCH = 20033,

    /**
    * Contact V-Key for assistance.
    * > Note: This should never happen if all error codes from starting V-OS are captured. The condition which triggers this is when `customerKey` = `null`, `customerId` = `0`, and `customerFeature` = `0` are returned from V-OS.
    */
    VGUARD_ERROR_LICENSE_VERIFICATION = 20034,

    /**
    * __Cause(s):__
    * SSL hooking detected.
    * __Solution(s):__
    * Remove the source of SSL hooking.
    */
    VGUARD_ERROR_HOOK_SSL_FOUND = 20060, // [iOS Only]

    /**
    * __Cause(s):__
    * C function hooking detected.
    * __Solution(s):__
    * Remove the source of C function hooking.
    */
    VGUARD_ERROR_HOOK_C_FUNCTION_FOUND = 20061, // [iOS Only]

    /**
    * __Cause(s):__
    * SSL pinning is detected on the host.
    */
    VGUARD_ERROR_SSL_PINNING_FOUND = 20070 // [iOS Only]
};

@end
