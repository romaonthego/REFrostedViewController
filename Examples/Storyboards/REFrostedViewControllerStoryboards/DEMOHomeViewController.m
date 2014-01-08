//
//  DEMOHomeViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"

@interface DEMOHomeViewController ()

@end

@implementation DEMOHomeViewController

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
