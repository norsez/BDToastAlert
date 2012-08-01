//
//  BDDefaultToastView.m
//  Photosophia
//
//  Created by Nor Oh on 7/19/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import "BDDefaultToastView.h"

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
    _textLabel.textAlignment = UITextAlignmentCenter;
    _textLabel.lineBreakMode = UILineBreakModeWordWrap;
    _textLabel.numberOfLines = 0;
    _textLabel.opaque = NO;
    _textLabel.textColor = [UIColor lightTextColor];
    _textLabel.shadowColor = [UIColor lightTextColor];
    _textLabel.shadowOffset = CGSizeMake(0, 1);
    self.textBorderWidth = 15;
    [self addSubview:_textLabel];
    _textLabel.center = self.center;
    self.opaque = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textLabel.autoresizingMask = self.autoresizingMask;
    self.maximumSize = CGSizeMake(300, 60);
    self.startGradientColor = [UIColor colorWithRed: 0.4 green: 0.84 blue: 0.99 alpha: 0.85];
    self.endGradientColor = [UIColor colorWithRed: 0.05 green: 0.65 blue: 0.99 alpha: 0.9];
    self.shadowColor = [UIColor colorWithRed: 0.38 green: 0.38 blue: 0.38 alpha: 0.79];
    self.backgroundRadius = 4;
    
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
                                       lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, labelSize.width + self.textBorderWidth*2, labelSize.height + self.textBorderWidth*2);
    _textLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    _textLabel.frame = CGRectOffset(_textLabel.frame, self.textBorderWidth, self.textBorderWidth);
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
