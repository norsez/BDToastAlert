//
//  BDToastAlert.m
//  BDToastAlert
//
//
//  Created by Norsez Orankijanan on 5/19/12.
//
//  Copyright (c) 2012, Norsez Orankijanan (Bluedot) All Rights Reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, 
//  this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation 
//  and/or other materials provided with the distribution.
//
//  3. Neither the name of Bluedot nor the names of its contributors may be used 
//  to endorse or promote products derived from this software without specific
//  prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.

#import "BDToastAlert.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+BDToastAlert.h"

#define kIntervalDelayHide 3
#define kIntervalFade 0.35
#define kMargin 8
#define kMaxHeight 100
#define kIntervalDelayAllowDuplicateMessage 2
#define kColorError [UIColor colorWithRed:0.4 green:0 blue:0 alpha:0.67]
#define kHeightKeyboard  215

@interface BDToastAlert (){
    NSMutableSet *_shownTexts; //these texts are removed within kIntervalDelayAllowDuplicateMess
    NSMutableArray *_allActiveToasts;
    dispatch_queue_t _serial_q;
    BOOL _isKeyboardShowing;
}
- (void)_removeShownText:(NSString*)text;
- (void)_queueToastViewWithText:(NSString*)text onViewController:(UIViewController*)viewToShowOn withColor:(UIColor*)color;
- (void)_showToastOnView:(UIView*)viewToShowOn withLabel:(UILabel*)label container:(UIView*)container;
- (void)_clearToastsNotInKeyWindow;


@end

@implementation BDToastAlert

- (NSArray *)allActiveToasts
{
    return [_allActiveToasts copy];
}

- (void)onDidShowKeyboard:(NSNotification*)notif
{
    _isKeyboardShowing = YES;
}

- (void)onDidHideKeyboard:(NSNotification*)notif
{
    _isKeyboardShowing = NO;
}

- (void)showToastWithText:(NSString*)text onViewController:(UIViewController*)ctrlToShowOn;
{
    dispatch_sync(_serial_q, ^{
        [self _queueToastViewWithText:text onViewController:ctrlToShowOn withColor:nil];
    });

}

-(void)_removeShownText:(NSString*)text
{
    dispatch_sync(_serial_q, ^{
        [_shownTexts removeObject:text];
    });
}

-(void)_queueToastViewWithText:(NSString *)text onViewController:(UIViewController *)controllerToShowOn withColor:(UIColor *)customizedColor
{
    if (text == nil) {
        return;
    }
    
    if ([_shownTexts containsObject:text]) {
        [self performSelector:@selector(_removeShownText:) withObject:text afterDelay:kIntervalDelayAllowDuplicateMessage];
        return;
    }
    
    UIView *viewToShowOn = nil;
    if (controllerToShowOn.presentedViewController) {
        viewToShowOn = controllerToShowOn.presentedViewController.view;
    }else{
        viewToShowOn = controllerToShowOn.view;
    }
    
    //DLog(@"Showing Alert…");
    if (viewToShowOn == nil) {
        viewToShowOn = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    }
    
    if  ([viewToShowOn isKindOfClass:[UIScrollView class]]){
        UIScrollView * scrollview = (UIScrollView*)viewToShowOn;
        viewToShowOn = scrollview.superview.superview;
        if (viewToShowOn == nil) {
            viewToShowOn = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        }
    }
    
    for (UIView *toast in _allActiveToasts) {
        if  (toast.superview == viewToShowOn){
            [toast removeFromSuperview];
        }
    }
    
    UILabel *_label;
    UIView *_container;
    if  (!_label){
        CGSize screenSize;
        
        if (viewToShowOn == nil) {
            screenSize = [[UIScreen mainScreen]bounds].size;            
        }else {
            screenSize = viewToShowOn.frame.size;
        }
        
        _container = [UILabel framedLabelWithText:text textAttributes:self.textAttributes constraintToSize:CGSizeMake(screenSize.width-20, kMaxHeight) borderWidth:kMargin];
        _container.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        _label = [_container.subviews objectAtIndex:0];
        
        if (customizedColor){
            _container.backgroundColor = customizedColor;
        }else if (self.toastColor) {
            _container.backgroundColor = self.toastColor;
        }
        
    }
    _label.text = text;
    [_shownTexts addObject:text];
    [self _showToastOnView:viewToShowOn withLabel:_label container:_container];    

    
}

- (void)_showToastOnView:(UIView *)viewToShowOn withLabel:(UILabel *)label container:(UIView *)container
{

    container.alpha = 0.f;
    container.center = viewToShowOn.center;
    CGFloat yOffset = 0;
    
//    CGFloat heightOfViewToShowOn = viewToShowOn.frame.size.height;
    
    
    yOffset = self.toastOriginY + kMargin - (_isKeyboardShowing?kHeightKeyboard:0);
    container.frame = CGRectMake(container.frame.origin.x, 
                                 yOffset,
                                 container.frame.size.width, 
                                 container.frame.size.height);
    
    container.frame = CGRectIntegral(container.frame);
    
//    DLog(@"toast frame: %@, viewToShowOn: %@, super view %@", NSStringFromCGRect(container.frame),
//         NSStringFromCGRect(viewToShowOn.frame),
//         viewToShowOn.superview);

    [_allActiveToasts addObject:container];
    [viewToShowOn addSubview:container];
    [viewToShowOn bringSubviewToFront:container];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kIntervalFade 
                         animations:^{
                             container.alpha = 1;
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:kIntervalFade 
                                                   delay:kIntervalDelayHide options:UIViewAnimationOptionTransitionCrossDissolve
                                              animations:^{
                                                  container.alpha = 0;
                                              } completion:^(BOOL finished) {
                                                  [self performSelector:@selector(_removeShownText:) withObject:label.text afterDelay:kIntervalDelayAllowDuplicateMessage];
                                                  [container removeFromSuperview];
                                                  [_allActiveToasts removeObject:container];
                                              }];
                         }];
    });

}

- (void)showToastForError:(NSError *)error
{
    [self alertError:error];
}

- (void)alertWithErrorMessage:(NSString *)message title:(NSString *)title
{
    [self _clearToastsNotInKeyWindow];
    dispatch_sync(_serial_q, ^{
        [self _queueToastViewWithText:message onViewController:nil withColor:kColorError];
    });
}

- (void)alertError:(NSError *)error
{
    [self alertWithErrorMessage:error.localizedDescription title:nil];
}

- (void)alertWithMessage:(NSString *)message title:(NSString *)title
{
    [self _clearToastsNotInKeyWindow];
    [self showToastWithText:message onViewController:nil];
}

- (void)_clearToastsNotInKeyWindow
{
    for (UIView *toasts in _allActiveToasts) {
        if (toasts.superview != [[UIApplication sharedApplication] keyWindow].rootViewController.view) {
            [toasts removeFromSuperview];
        }
    }
}

- (void)clearAllToasts
{
    dispatch_sync(_serial_q, ^{
        for (UIView * toast in _allActiveToasts) {
            [toast removeFromSuperview];
        }
        [_allActiveToasts removeAllObjects];
        [_shownTexts removeAllObjects];
    });
}

#pragma mark - singleton
@synthesize textAttributes, toastColor;
- (id)init
{
    self = [super init];
    if(self){
        _serial_q = dispatch_queue_create("BDToastAlert serial queue", NULL);
        _shownTexts = [[NSMutableSet alloc] init];
        _allActiveToasts = [[NSMutableArray alloc] init];
        self.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:14], UITextAttributeFont,
                               [UIColor whiteColor], UITextAttributeTextColor,
                               [UIColor darkGrayColor], UITextAttributeTextShadowColor,
                               [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
                               nil];
        self.toastColor = [UIColor colorWithRed:0 green:0.12 blue:0.34 alpha:0.85];
        
        self.toastOriginY = 0; 
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDidShowKeyboard:) 
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDidHideKeyboard:) 
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
    }
    return self;
}


+ (BDToastAlert *)sharedInstance
{
    static dispatch_once_t once;
    static BDToastAlert * singleton;
    dispatch_once(&once, ^ { singleton = [[BDToastAlert alloc] init]; });
    return singleton;
}


@synthesize toastOriginY;

@end
