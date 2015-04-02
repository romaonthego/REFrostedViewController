//
//  REConfigurationsManager.h
//  REFrostedViewControllerExample
//
//  Created by Alexis Santos Pérez on 27/12/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//
// ****************************************************************************************
//  Following 'The pragmatic programmer':
//
//  Rule #6: Configure, don’t integrate
//
//  Details mess up our pristine code, they change frequently. Every change to the code is a risk to break the system.
//  To avoid that, you should get the details out of the code, in configuration files.
//  Configurable code is called « soft code », it’s adaptable to change.
//
//  Whenever you come to the point where you put details into your codebase, stop, and extract them out of it.
//  The time you spend now will pay-off ten times in the future.
// ****************************************************************************************

#import <Foundation/Foundation.h>

#import "REFrostedViewController.h"

@interface REConfigurationsManager : NSObject

+ (instancetype)sharedManager;

- (CGFloat)backgroundFadeAmount;
- (BOOL)liveBlur;
- (UIColor *)blurTintColor;
- (CGFloat)blurRadius;
- (CGFloat)blurSaturationDeltaFactor;
- (NSTimeInterval)animationDuration;
- (BOOL)limitMenuViewSize;
- (CGSize)menuViewSize;
- (REFrostedViewControllerLiveBackgroundStyle)liveBlurBackgroundStyle;
- (REFrostedViewControllerDirection)direction;

@end
