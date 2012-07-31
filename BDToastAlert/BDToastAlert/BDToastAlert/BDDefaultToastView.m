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
    self.textBorderWidth = 2;
    [self addSubview:_textLabel];
    _textLabel.center = self.center;
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
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor* gradientColor = [UIColor colorWithRed: 0.62 green: 0.79 blue: 0.86 alpha: 0.9];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.06 green: 0.6 blue: 0.9 alpha: 0.9];
    UIColor* outerShadowColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.6];
    UIColor* innerShadowColor = [UIColor colorWithRed: 0.34 green: 0.68 blue: 0.75 alpha: 0.9];

    NSArray* gradientColors = [NSArray arrayWithObjects: 
                               (id)gradientColor.CGColor, 
                               (id)gradientColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    UIColor* outerShadow = outerShadowColor;
    CGSize outerShadowOffset = CGSizeMake(1, 2);
    CGFloat outerShadowBlurRadius = 5;
    UIColor* innerShadow = innerShadowColor;
    CGSize innerShadowOffset = CGSizeMake(1, 3);
    CGFloat innerShadowBlurRadius = 2;
    
    CGRect frameRect = self.bounds;
    CGFloat frameRectRadius = 8;
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: frameRect cornerRadius: frameRectRadius];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, outerShadowOffset, outerShadowBlurRadius, outerShadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(124, 46.5), CGPointMake(124, 91.5), 0);
    CGContextEndTransparencyLayer(context);
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = innerShadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = innerShadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    innerShadowBlurRadius,
                                    innerShadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)setToastText:(NSString *)toastText
{
    _textLabel.text = toastText;
    [self setNeedsLayout];
}

- (CGSize)sizeConstraint
{
    return [UIApplication sharedApplication].keyWindow.bounds.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize labelSize = [_textLabel.text sizeWithFont:_textLabel.font
                        constrainedToSize:[self sizeConstraint]
                                       lineBreakMode:UILineBreakModeWordWrap];
    _textLabel.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.bounds = CGRectInset(_textLabel.bounds, self.textBorderWidth, self.textBorderWidth);
    _textLabel.center = self.center;
    [self setNeedsDisplay];
}

@synthesize textBorderWidth;

@end
