//
//  VGuardExceptionHandler.h
//  VGuard
//
//  Created by Chinwee Koh on 8/12/14.
//  Copyright (c) 2014 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VGuardExceptionHandlerProtocol <NSObject>

- (void)vGuardExceptionHandler:(NSException *)exception;

@end

@interface VGuardExceptionHandler : NSObject

@property (unsafe_unretained, nonatomic) id<VGuardExceptionHandlerProtocol> delegate;

/**
 * Discussion: You must setup this instance before setting the V-Guard instance in VGuardManager class, this class "VGuardExceptionHandler" will notify you if there are any errors during the V-Guard operation. Use the 'vGuardExceptionHandler' method in VGuardExceptionHandlerProtocol to log the exception raise in V-Guard.
 */
+ (instancetype)sharedManager;

/**
 * Discussion: allow V-Guard to send the stack trace log to V-Track,
    default is 'TRUE', stack trace log is send to V-Track when V-Guard encounter bug
 */
@property (assign, nonatomic) BOOL allowSendStacktraceLog;

@end
