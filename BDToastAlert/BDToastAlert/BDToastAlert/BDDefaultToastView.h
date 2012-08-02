//
//  BDDefaultToastView.h
//  Photosophia
//
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
#import "BDToastViewProtocol.h"

/**
 Default Toast that is used by BDToastAlert.
 Subclass this class to customize your own look of toast.
 Or you can create a totally new class. But remember
 to conform to the BDToastViewProtocol.
 */
@interface BDDefaultToastView : UIView <BDToastViewProtocol>

/**
 The distance from text to view's bounds on all sides.
 */
@property (nonatomic, assign) CGFloat textBorderWidth;

/** 
 The text label that displays the text.
 Subclasses can configure the text appearance here.
 */
@property (nonatomic, strong, readonly) UILabel* textLabel;

/**
 Maximum size of the text label.
 */
@property (nonatomic, assign) CGSize maximumSize;

/**
 The start gradient color of the background.
 */
@property (nonatomic, strong) UIColor* startGradientColor;

/**
 The end gradient color of the background.
 */
@property (nonatomic, strong) UIColor* endGradientColor;

/**
 The shadow color of the background.
 */
@property (nonatomic, strong) UIColor* shadowColor;

/**
 The corner radius of the background.
 */
@property (nonatomic, assign) CGFloat backgroundRadius;



@end
