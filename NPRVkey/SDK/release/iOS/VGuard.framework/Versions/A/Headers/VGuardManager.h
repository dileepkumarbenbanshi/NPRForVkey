//
//  VGuardManager.h
//  VGuard
// 
//  Copyright (c) 2012 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    VGUARD_UNSAFE=0,
    VGUARD_SAFE,
    VGUARD_UNDETERMINE
}   VGUARD_STATUS;

typedef enum {
    VOS_NOTOK=0,
    VOS_OK
}   VOS_STATUS;


@protocol VGuardManagerProtocol <NSObject>
@required

/**
 * Discussion: status of VOS, error if any failure
 */
-(void)statusVOS:(VOS_STATUS)status withError:(NSError *)error;


/**
 * Discussion: status of Vguard, error if any failure
 */
-(void)statusVGuard:(VGUARD_STATUS)status withError:(NSError *)error;


/**
 * Tells the delegate whether V-OS App Protection initialization was successful or not.
 * @discussion Your implementation of this method should make decision on what to do next after receiving the status of V-OS App Protection initialization
 * @param status A BOOL value indicating the V-Guard initialization status. Status is YES if V-Guard initialization was successful. Otherwise, status is NO.
 * @param error NSError if there is any error during initialization. Otherwise, error is Nil.
 */
- (void)vGuardDidFinishInitializing:(BOOL)status withError:(NSError *)error;

/**
 * Discussion: SSL hooking or pinning detection
 */
-(void)sslErroDetected:(NSError *)error;

@optional

/**
 * Tells the delegate when V-OS App Protection has detected a crash in previous launch
 * @discussion Your implementation of this method should create a business logic on what to do when V-OS App Protection notifies a detection of a crash.
 */
- (void)vGuardDidDetectCrash;

@end

@interface VGuardManager : NSObject 
@property (unsafe_unretained, nonatomic) id<VGuardManagerProtocol> delegate;
@property (assign, nonatomic) BOOL isDebug; // Set debug to TRUE during development set debug to FALSE for distribution

/**
 * Create a VGuardManager instance
 *
 * Parameters: none
 *
 * Return Value: an instance of VGuardManager
 *
 * Discussion:
 */
+ (VGuardManager *)sharedVGuardManager;


/**
 * Create a VGuardManager initialization
 *
 * Parameters: none
 *
 * Return Value: YES if VGuardManager initialization success
 *
 * Discussion:
 */
- (BOOL)initializeVGuard;


/**
 * set Server URL for ThreatIntelligence feature
 *
 * Parameters: server URL to connect
 */
- (void)setThreatIntelligenceServerURL:(NSString *)serverURL;


/**
* Send Device Info to ThreatIntelligence server
*
* Return Value: YES if request sent successfully, NO if any failure
*
*/
- (BOOL)sendDeviceInfo;


/**
 * Start the VGuard scanning
 *
 * Parameters: none
 *
 * Return Value: status from delegate result
 *
 * Discussion: start the VGuard scanning
 */
- (void)start;

/**
 * Get Customer ID
 * 
 * Parameters: none
 * 
 * Return Value: CustomerID if VOS started Sucsessfully else return nill
 *
 * Discussion: Call this method after started the VOS Sucsessfully
 */
- (NSString * )getCustomerID;


/**
 * Get Password
 *
 * Parameters: none
 *
 * Return Value: Password if VOS started Sucsessfully else return nil
 *
 * Discussion: Call this method after started the VOS Sucsessfully
 */
- (NSString *)getPassword;


/**
 * Lock VOS
 *
 * Parameters: none
 *
 * Return Value:
 *
 * Discussion: Its stop the VOS and coulden't do VOS related stuff
 */
- (int)lockVOS;


/**
 * Encrypt Data
 *
 * Parameters: Data to encrypt
 *
 * Return Value: Encrypted Data and error if encryption failed
 *
 * Discussion: to string encoding convert it to NSData ([@"StringToEncode" dataUsingEncoding:NSUTF8StringEncoding];)
 */
- (NSData *)getEncryptData:(NSData *)data error:(NSError **)error;



/**
* Decrypt Data
*
* Parameters: Data to Decrypt
*
* Return Value: Decrypted Data and error if decryption failed
*
* Discussion: to string decoding use bellow practice
*
* NSString *decryptedString=[NSString stringWithUTF8String:[decryptedData bytes]];
* if (!decryptedString) {
*   decryptedString=[[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
* }
*
*/
- (NSData *)getDecryptData:(NSData *)data error:(NSError **)error;


/**
 * Encrypt String
 *
 * Parameters: String to encrypt
 *
 * Return Value: Encrypted string and nil if encryption failed
 *
 * Discussion:
 */
- (NSString *)encryptString:(NSString *)string;



/**
 * Decrypt String
 *
 * Parameters: String to Decrypt
 *
 * Return Value: Decrypted string and nill if decryption failed
 *
 * Discussion:
 */
- (NSString *)decryptString:(NSString *)string;


/**
 * Troubleshooting ID
 *
 * Parameters: none
 *
 * Return Value: Troubleshooting ID
 *
 * Discussion:
 *  
 */
- (NSString *)getDFPHashHash;

/**
 * VGuard Version Information
 *
 * Parameters: none
 *
 * Return Value: VGuard Version Info
 *
 * Discussion:
 *
 */
- (NSString *)getVGuardVersionInformation;

/**
 * VGuard SDK Version to syncronise API name, just a wrapping of getVGuardVersionInformation API
 *
 * Parameters: none
 *
 * Return Value: VGuard Version Info
 *
 */
- (NSString *)sdkVersion;

/**
 * This method tells the SDK whether or not to allow arbitrary networking. DEFAULT value is NO.
 * @param allow A boolean value to allow/disallow arbitrary networking.
 * @since 4.8.3
 */
- (void)allowsArbitraryNetworking:(BOOL)allow;

@end
