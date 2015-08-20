//
//  REFrostedStoryboardSegue.m
//  REFrostedViewControllerStoryboards
//
//  Created by Rahul Katariya on 20/08/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import "REFrostedStoryboardSegue.h"
#import "REFrostedViewController.h"

#pragma mark - SegueSetController segue identifiers

NSString * const RESegueLeftIdentifier = @"re_left";
NSString * const RESegueFrontIdentifier = @"re_front";


#pragma mark - REFrostedSetStoryboardSegue class

@implementation REFrostedSetStoryboardSegue

- (void)perform {
    NSString *identifier = self.identifier;
    REFrostedViewController *fvc = self.sourceViewController;
    UIViewController *dvc = self.destinationViewController;
    if ( [identifier isEqualToString:RESegueFrontIdentifier] ) {
        fvc.contentViewController = dvc;
    } else if ( [identifier isEqualToString:RESegueLeftIdentifier] ) {
        fvc.menuViewController = dvc;
        fvc.direction = REFrostedViewControllerDirectionLeft;
    }
    [fvc re_displayController:fvc.contentViewController frame:fvc.view.bounds];
}

@end


#pragma mark - SWRevealViewControllerSeguePushController class

@implementation REFrostedPushStoryboardSegue

- (void)perform {
    UIViewController *vc = self.sourceViewController;
    REFrostedViewController *fvc = vc.frostedViewController;
    UIViewController *dvc = self.destinationViewController;
    fvc.contentViewController = dvc;
    [fvc hideMenuViewController];
}

@end
