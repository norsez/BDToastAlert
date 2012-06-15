//
//  UILabel+Extension.m
//  Photosophia
//
//  Created by Nor Oh on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Extension.h"
#import <QuartzCore/QuartzCore.h>
@implementation UILabel (Extension)
+ (UIView *)framedLabelWithText:(NSString *)text textAttributes:(NSDictionary *)textAttributes constraintToSize:(CGSize)constraintSize borderWidth:(CGFloat)frameWidth
{
    CGSize labelSize = [text sizeWithFont:[textAttributes valueForKey:UITextAttributeFont] 
                        constrainedToSize:constraintSize 
                            lineBreakMode:UILineBreakModeTailTruncation];
    CGSize containerSize = CGSizeMake(labelSize.width + frameWidth * 2, labelSize.height + frameWidth * 2);
    UILabel *_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    UIView *_container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize.width, containerSize.height)];
    _label.frame = CGRectOffset(_label.frame, frameWidth, frameWidth);
    [_container addSubview:_label];
    _container.layer.cornerRadius = frameWidth;
    _container.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.85];
    _container.opaque = NO;
    _container.userInteractionEnabled = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.opaque = NO;
    _label.userInteractionEnabled = NO;        
    _label.font = [textAttributes valueForKey:UITextAttributeFont];
    _label.textAlignment = UITextAlignmentCenter;
    _label.lineBreakMode = UILineBreakModeTailTruncation;
    _label.numberOfLines = 0;
    _label.textColor = [textAttributes valueForKey:UITextAttributeTextColor];
    _label.shadowColor = [textAttributes valueForKey:UITextAttributeTextShadowColor];
    _label.shadowOffset = [(NSValue*) [textAttributes valueForKey:UITextAttributeTextShadowOffset] CGSizeValue];
    return _container;
}    
    
@end
