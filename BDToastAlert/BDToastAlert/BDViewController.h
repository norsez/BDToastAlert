//
//  BDViewController.h
//  BDToastAlert
//
//  Created by Nor Oh on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField* textField;

- (IBAction)showOnce:(id)sender;
- (IBAction)simulateDuplicateAlerts:(id)sender;
- (IBAction)simulateNonDuplicateAlerts:(id)sender;
@end
