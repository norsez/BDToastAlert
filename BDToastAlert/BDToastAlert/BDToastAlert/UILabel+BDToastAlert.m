//
//  UILabel+Extension.m
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

#import "UILabel+BDToastAlert.h"
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
