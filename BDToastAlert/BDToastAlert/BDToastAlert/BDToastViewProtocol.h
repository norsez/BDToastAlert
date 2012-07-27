//
//  BDToastViewProtocol.h
//  Photosophia
//
//  Created by Nor Oh on 7/19/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Protocol for a custom toast view.
 */
@protocol BDToastViewProtocol <NSObject>
/**
 BDToastAlert calls this method to set text to the custom view.
 @param toastText the text to display on the custom toast view.
 */
- (void) setToastText:(NSString*)toastText;

/**
 BDToastAlert calls this method to resize the custom view
 to the input text.
 @param textToFit the text that the propcol adopter must resize 
   itself to.
 */
- (void) sizeToFitText:(NSString*)textToFit;

@end
