//
//  BDViewController.m
//  BDToastAlert
//
//  Created by Nor Oh on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BDViewController.h"
#import "BDToastAlert.h"
#import "BDViewController+Private.h"
@interface BDViewController ()

@end

@implementation BDViewController

- (void)showOnce:(id)sender
{
    BDToastAlert *toast = [BDToastAlert sharedInstance];
    
    //You can set up the text attributes and the toast background color
    toast.toastColor = [UIColor colorWithWhite:0.25 alpha:0.9];
    toast.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys: 
                            [UIFont boldSystemFontOfSize:20], UITextAttributeFont,
                            [UIColor colorWithWhite:0.9 alpha:1], UITextAttributeTextColor,
                            nil];
    
    //show toast
    [toast showToastWithText:self.textField.text
                                    onViewController:self];
}



@synthesize textField;
@end
