//
//  BDToastAlert.h
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


#import <UIKit/UIKit.h>

enum BDToastVerticalAlignment {
    BDToastVerticalAlignmentCenter = 0,
    BDToastVerticalAlignmentTop = 1,
    BDToastVerticalAlignmentBottom = 2
    };
typedef NSUInteger BDToastVerticalAlignment;
@protocol BDToastViewProtocol;
/**
 * Non-obstructive message label alert. (Think Growl or Toast on Android.)
 * Toast default behavior automatically guards against displaying duplicate texts.
 */
@interface BDToastAlert : NSObject 

//display toast on a UIViewController's view.
- (void)showToastWithText:(NSString*)text 
         onViewController:(UIViewController*)ctrlToShowOn;

/**
 @return clear all Toasts everywhere in your app. 
 */

- (void)clearAllToasts;

/**
 @return All active toast UIView instances currently in your app. 
 */
-(NSArray*)allActiveToasts;

/**
 Vertical alignment of displayed toasts.
 */
@property (nonatomic, assign) BDToastVerticalAlignment verticalAlignment;



/**
 If this property is not nil, each time this class will display a toast,
 it will initialize a UIView specified by this property, and use it
 as custom Toast view. 
 
 The custom view must adapt BDToastProtocol. Or else, this class will
 fall back to the default toast view.
 */
@property (nonatomic, strong) NSString* customToastViewClassName;

//The singleton instance. Call this method for an instance. Do not use alloc, init or new.
+ (BDToastAlert *)sharedInstance;
@end
