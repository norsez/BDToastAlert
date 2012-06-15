//
//  BDViewController+Private.m
//  BDToastAlert
//
//  Created by Nor Oh on 6/15/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import "BDViewController+Private.h"

@implementation BDViewController (Private)
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(hideKeyboard:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}

- (void) hideKeyboard:(UITapGestureRecognizer*)g
{
    if (g.state == UIGestureRecognizerStateEnded){
        [self.textField resignFirstResponder];
    }
}
@end
