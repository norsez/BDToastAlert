//
//  BDDefaultToastView.m
//  Photosophia
//
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

#import "BDDefaultToastView.h"
#define kMinimumToastSize CGSizeMake(100, 30)
@interface BDDefaultToastView ()
{
    UILabel *_textLabel;
}
@end

@implementation BDDefaultToastView

- (void) initializeSubviews
{
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];    
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.numberOfLines = 0;
    _textLabel.opaque = NO;
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.shadowColor = [UIColor lightGrayColor];
    _textLabel.shadowOffset = CGSizeMake(0, 1);
    _textLabel.font = [UIFont systemFontOfSize: [UIFont buttonFontSize] + 5];
    self.textBorderWidth = 20;
    [self addSubview:_textLabel];
    _textLabel.center = self.center;
    self.opaque = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textLabel.autoresizingMask = self.autoresizingMask;
    self.maximumSize = CGSizeMake(300, 500);
    self.startGradientColor = [UIColor colorWithRed: 0.4 green: 0.84 blue: 0.99 alpha: 0.85];
    self.endGradientColor = [UIColor colorWithRed: 0.05 green: 0.65 blue: 0.99 alpha: 0.9];
    self.shadowColor = [UIColor colorWithRed: 0.38 green: 0.38 blue: 0.38 alpha: 0.79];
    self.backgroundRadius = 4;
    self.userInteractionEnabled = NO;
    self.bounds = CGRectMake(0, 0, kMinimumToastSize.width, kMinimumToastSize.height);
}


- (id)init
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = self.startGradientColor;
    UIColor* gradientColor2 = self.endGradientColor;
    UIColor* shadowColorAlpha = self.shadowColor;
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects: 
                               (id)gradientColor.CGColor, 
                               (id)gradientColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = shadowColorAlpha;
    CGSize shadowOffset = CGSizeMake(1, 3);
    CGFloat shadowBlurRadius = self.backgroundRadius;
    
    //// Frames
    CGRect frame = self.bounds;
    
    //// Abstracted Graphic Attributes
    CGRect toastViewRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.06), floor(CGRectGetWidth(frame) * 0.94), floor(CGRectGetHeight(frame) * 0.83));
    CGFloat toastViewCornerRadius = backgroundRadius;
    
    
    //// toastView Drawing
    UIBezierPath* toastViewPath = [UIBezierPath bezierPathWithRoundedRect: toastViewRect cornerRadius: toastViewCornerRadius];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [toastViewPath addClip];
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMidX(toastViewRect), CGRectGetMinY(toastViewRect)),
                                CGPointMake(CGRectGetMidX(toastViewRect), CGRectGetMaxY(toastViewRect)),
                                0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (NSString *)toastText
{
    return _textLabel.text;
}

- (void)setToastText:(NSString *)toastText
{
    _textLabel.text = toastText;
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize labelSize = [_textLabel.text sizeWithFont:_textLabel.font
                        constrainedToSize:self.maximumSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    self.bounds = CGRectMake(0,
                             0, 
                             labelSize.width + self.textBorderWidth*2, 
                             labelSize.height + self.textBorderWidth*2);
    _textLabel.frame = CGRectMake(self.textBorderWidth, 
                                  self.textBorderWidth, 
                                  labelSize.width, 
                                  labelSize.height);
    _textLabel.frame = CGRectIntegral(_textLabel.frame);
    [self setNeedsDisplay];
}


@synthesize textBorderWidth;
@synthesize maximumSize;
@synthesize endGradientColor;
@synthesize startGradientColor;
@synthesize shadowColor;
@synthesize backgroundRadius;
@synthesize textLabel=_textLabel;
@end
