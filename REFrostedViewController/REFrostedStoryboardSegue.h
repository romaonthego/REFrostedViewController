//
//  REFrostedStoryboardSegue.h
//  REFrostedViewControllerStoryboards
//
//  Created by Rahul Katariya on 20/08/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

// String identifiers to be applied to segues on a storyboard
extern NSString* const RESegueLeftIdentifier;  // this is @"sw_left"
extern NSString* const RESegueFrontIdentifier; // this is @"sw_front"

/* This will allow the class to be defined on a storyboard */

// Use this along with one of the above segue identifiers to segue to the initial state
@interface REFrostedSetStoryboardSegue : UIStoryboardSegue

@end

// Use this to push a view controller
@interface REFrostedPushStoryboardSegue : UIStoryboardSegue

@end