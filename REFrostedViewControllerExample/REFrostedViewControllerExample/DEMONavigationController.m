//
//  DEMONavigationController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"

@interface DEMONavigationController ()

@property (strong, readwrite, nonatomic) DEMOMenuViewController *menuViewController;

@end

@implementation DEMONavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuViewController = [[DEMOMenuViewController alloc] init];
    self.menuViewController.navigationController = self;
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    [self.menuViewController presentFromViewController:self animated:YES completion:nil];
}

#pragma mark -
#pragma mark Rotation handling

- (BOOL)shouldAutorotate
{
    return self.menuViewController.hidden;
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.menuViewController presentFromViewController:self panGestureRecognizer:sender];
}

@end
