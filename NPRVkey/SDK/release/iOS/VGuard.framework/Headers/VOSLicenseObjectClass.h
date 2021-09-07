//
//  VOSLicenseObjectClass.h
//  VGuard
//
//  Created by Chinwee Koh on 29/12/14.
//  Copyright (c) 2014 V-Key Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOSLicenseObjectClass : NSObject
+(id)sharedManager;
@property BOOL cacheFeature;
@property int orgainsationID;
@property (nonatomic, strong) NSString *vGuardKey;
@end
