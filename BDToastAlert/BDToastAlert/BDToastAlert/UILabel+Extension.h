//
//  UILabel+Extension.h
//  BDToastAlert
//
//  Created by Nor Oh on 5/19/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+ (UIView*) framedLabelWithText:(NSString*)text textAttributes:(NSDictionary*)textAttributes 
               constraintToSize:(CGSize)constraintSize borderWidth:(CGFloat)frameWidth;
@end
