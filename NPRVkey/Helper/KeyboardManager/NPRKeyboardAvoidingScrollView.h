//
//  NPRKeyboardAvoidingScrollView.h
//  NPR_census
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+NPRKeyboardAvoidingAddition.h"

@interface NPRKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>
- (void)contentSizeToFit;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
