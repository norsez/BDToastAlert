//
//  BDToastAlert.h
//  BDToastAlert
//
//  Created by Nor Oh on 5/19/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Non-obstructive message label alert. (Think Growl or Toast on Android.)
 * Toast default behavior automatically guards against displaying duplicate texts.
 */
@interface BDToastAlert : NSObject 

//display toast on a UIViewController's view.
- (void)showToastWithText:(NSString*)text onViewController:(UIViewController*)ctrlToShowOn;

//clear all Toasts everywhere in your app.
- (void)clearAllToasts;

//All active toast UIView instances currently in your app.
-(NSArray*)allActiveToasts;



//Toast text attributes. See http://developer.apple.com/library/ios/documentation/uikit/reference/NSString_UIKit_Additions/Reference/Reference.html#//apple_ref/doc/uid/TP40006893-CH3-DontLinkElementID_3
@property (nonatomic, strong) NSDictionary* textAttributes;

//Toast background color. You can use alpha for transparency effect. The size of toast varies to fit your text.
@property (nonatomic, strong) UIColor *toastColor;

//The singleton instance. Call this method for an instance. Do not use alloc, init or new.
+ (BDToastAlert *)sharedInstance;
@end
