//
//  BDToastAlert.h
//  BDToastAlert
//
//  Created by Norsez Orankijanan on 5/19/12.
//
//Copyright (c) 2012, Norsez Orankijanan (Bluedot) All Rights Reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//
//1. Redistributions of source code must retain the above copyright notice, 
//this list of conditions and the following disclaimer.
//2. Redistributions in binary form must reproduce the above copyright notice, 
//this list of conditions and the following disclaimer in the documentation 
//and/or other materials provided with the distribution.
//3. Neither the name of Bluedot nor the names of its contributors may be used 
//to endorse or promote products derived from this software without specific
//prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
//SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
//CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
//OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


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
