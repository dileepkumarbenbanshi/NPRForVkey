//
//  VGuardCustomAPI.h
//  VGuard
//
//  Created by Chinwee Koh on 8/12/14.
//  Copyright (c) 2014 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGuardCustomAPI : NSObject

/**
 * Discussion: You must setup this instance before setting the V-Guard instance in VGuardManager class, this class "VGuardCustomeAPI" will allow you to customize the message for invalid files and critical alert arise during the V-Guard operation.
 */
+ (id)sharedManager;

/**
 * Discussion: customize the title's content for critical alert
 */
@property (strong, nonatomic) NSString *customTitleMessageForCriticalAlert;

/**
 * Discussion: customize the body's content for critical alert
 */
@property (strong, nonatomic) NSString *customBodyMessageForCriticalAlert;

/**
 * Discussion: customize the title's content for invalid files (profile, vkeylicensepack),
 if not set will use default "Alert"
 */
@property (strong, nonatomic) NSString *customTitleMessageForInvalidFiles;

/**
 * Discussion: customize the body's content for invalid files (profile, vkeylicensepack),
 if not set will use default:
 "Your application appears to be have been tampered with, and could be under attack. For your security, please re-download the application from the App Store / Play Store."
 */
@property (strong, nonatomic) NSString *customBodyMessageForInvalidFiles;

/**
 * Discussion: customize the button's content for Quit alert view.
 if not set will use default "Quit"
 */
@property (strong, nonatomic) NSString *customButtonTitleForQuitAlert;

@end
