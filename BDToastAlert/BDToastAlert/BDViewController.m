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
{
    BDToastAlert *_toast;
    NSUInteger _toastNo;
}

- (BDToastAlert*)toast;
- (void)_simulateConnectionFail:(NSString*)text;
@end

@implementation BDViewController

#pragma mark - IBAction
- (void)showOnce:(id)sender
{
    
    
    //show toast
    [self.toast showToastWithText:self.textField.text
                                    onViewController:self];
}


-(void)simulateDuplicateAlerts:(id)sender
{
    //When issue duplicate text in a relatively short interval
    //BDToastAlert suppresses the duplicate text
    NSString *duplicateText = @"Connection Failed";
    
    //issue once
    [self _simulateConnectionFail:duplicateText];
    
    //issue same text again in 5 seconds
    [self performSelector:@selector(_simulateConnectionFail:) 
               withObject:duplicateText
               afterDelay:5];
    
    //You should see the duplicateText displayed only once (toast doesn't blink) in 5 seconds
}

-(void)simulateNonDuplicateAlerts:(id)sender
{
    //Contrasting with the duplicate alert test above,
    //BDToastAlert does not suppress different text issued in an even shorter interval than the first case.
    
    //issue once
    [self _simulateConnectionFail:@"Text 1"];
    
    //issue same text again in 5 seconds
    [self performSelector:@selector(_simulateConnectionFail:) 
               withObject:@"Text 2"
               afterDelay:1];
    
    //You should see both texts displayed.

}


#pragma mark - private
- (BDToastAlert *)toast
{
    if (!_toast) {
        _toast = [BDToastAlert sharedInstance];
    }
    return _toast;
}

-(void)_simulateConnectionFail:(NSString*)text
{
    [self.toast showToastWithText:text onViewController:self];
    NSLog(@"Toast #%d", ++_toastNo);
}

@synthesize textField;
@end
