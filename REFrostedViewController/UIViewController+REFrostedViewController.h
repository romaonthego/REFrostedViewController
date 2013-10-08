//
//  UIViewController+REFrostedViewController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 10/8/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REFrostedViewController;

@interface UIViewController (REFrostedViewController)

@property (strong, readonly, nonatomic) REFrostedViewController *frostedViewController;

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame;
- (void)re_hideController:(UIViewController *)controller;

@end
