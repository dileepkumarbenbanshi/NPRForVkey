//
//  UIScrollView+NPRKeyboardAvoidingAddition.h
//  NPR_census
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (NPRKeyboardAvoidingAdditions)
- (BOOL)NPRKeyboardAvoiding_focusNextTextField;
- (void)NPRKeyboardAvoiding_scrollToActiveTextField;

- (void)NPRKeyboardAvoiding_keyboardWillShow:(NSNotification*)notification;
- (void)NPRKeyboardAvoiding_keyboardWillHide:(NSNotification*)notification;
- (void)NPRKeyboardAvoiding_updateContentInset;
- (void)NPRKeyboardAvoiding_updateFromContentSizeChange;
- (void)NPRKeyboardAvoiding_assignTextDelegateForViewsBeneathView:(UIView*)view;
- (UIView*)NPRKeyboardAvoiding_findFirstResponderBeneathView:(UIView*)view;
-(CGSize)NPRKeyboardAvoiding_calculatedContentSizeFromSubviewFrames;
@end
