//
//  UIViewController+REFrostedViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 10/8/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"

@implementation UIViewController (REFrostedViewController)

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    controller.view.frame = frame;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)re_hideController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

- (REFrostedViewController *)frostedViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[REFrostedViewController class]]) {
            return (REFrostedViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
