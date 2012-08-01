//
//  BDDefaultToastView.h
//  Photosophia
//
//  Created by Nor Oh on 7/19/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

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
