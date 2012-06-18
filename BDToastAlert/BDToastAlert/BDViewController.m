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

- (void)errorAlert:(id)sender
{
    //this method shows an NSError's localized description text in Red regardless of your toast customization.
    [_toast showToastForError:[NSError errorWithDomain:NSCocoaErrorDomain
                                                 code:-1 
                                             userInfo:[NSDictionary dictionaryWithObject:@"This is an error!"
                                                                                  forKey:NSLocalizedDescriptionKey]]];
}


#pragma mark - private
- (BDToastAlert *)toast
{
    if (!_toast) {
        _toast = [BDToastAlert sharedInstance];
        //You can set up the text attributes and the toast background color
        self.toast.toastColor = [UIColor colorWithWhite:0.25 alpha:0.9];
        self.toast.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys: 
                                     [UIFont boldSystemFontOfSize:20], UITextAttributeFont,
                                     [UIColor colorWithWhite:0.9 alpha:1], UITextAttributeTextColor,
                                     nil];

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
