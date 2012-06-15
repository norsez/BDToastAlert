//
//  BDToastAlert.h
//  Photosophia
//
//  Created by Nor Oh on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDAlertDelegate.h"
/**
 * Android-like Toast alert. The default parent view is the app's key window.
 */
@interface BDToastAlert : NSObject <BDAlertDelegate>

-(NSArray*)allActiveToasts;
- (void)clearAlert;
- (void)showToastWithText:(NSString*)text onViewController:(UIViewController*)ctrlToShowOn;

@property (nonatomic, strong) NSDictionary* textAttributes;
@property (nonatomic, strong) UIColor *toastColor;

+ (BDToastAlert *)sharedInstance;
@end
