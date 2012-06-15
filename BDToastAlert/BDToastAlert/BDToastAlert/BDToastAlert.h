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
 */
@interface BDToastAlert : NSObject 

-(NSArray*)allActiveToasts;
- (void)clearAlert;
- (void)showToastWithText:(NSString*)text onViewController:(UIViewController*)ctrlToShowOn;

@property (nonatomic, strong) NSDictionary* textAttributes;
@property (nonatomic, strong) UIColor *toastColor;

+ (BDToastAlert *)sharedInstance;
@end
