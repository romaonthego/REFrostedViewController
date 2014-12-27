//
//  REConfigurationsManager.m
//  REFrostedViewControllerExample
//
//  Created by Alexis Santos Pérez on 27/12/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//
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

#import "REConfigurationsManager.h"

#import "UIColor+REColorConversion.h"

static NSString * const kJSONFileName = @"Configuration";
static NSString * const kSettingsKey = @"settings";
static NSString * const kBackgroundFadeAmountKey = @"backgroundFadeAmount";
static NSString * const kLiveBlurKey = @"liveBlur";
static NSString * const kBlurRadiusKey = @"blurRadius";
static NSString * const kBlurSaturationDeltaFactorKey = @"blurSaturationDeltaFactor";
static NSString * const kAnimationDurationKey = @"animationDuration";
static NSString * const kLiveBlurBackgroundStyleKey = @"liveBlurBackgroundStyle";
static NSString * const kLimitMenuViewSizeKey = @"limitMenuViewSize";
static NSString * const kMenuViewSizeKey = @"menuViewSize";
static NSString * const kMenuViewSizeWidthKey = @"width";
static NSString * const kMenuViewSizeHeightKey = @"height";
static NSString * const kBlurTintColorKey = @"blurTintColor";
static NSString * const kHexColorKey = @"hexColor";
static NSString * const kAlphaKey = @"alpha";
static NSString * const kFrostedViewControllerDirectionKey = @"frostedViewControllerDirection";
static NSString * const kFrostedViewControllerDirectionLeftKey = @"directionLeft";
static NSString * const kFrostedViewControllerDirectionRightKey = @"directionRight";
static NSString * const kFrostedViewControllerDirectionTopKey = @"directionTop";
static NSString * const kFrostedViewControllerDirectionBottomKey = @"directionBottom";

static NSString * const kLiveBlurBackgroundStyleLightValue = @"light";
static NSString * const kLiveBlurBackgroundStyleDarkValue = @"dark";

#pragma mark - Class extension

@interface REConfigurationsManager ()

@property (nonatomic) NSDictionary *settings;

@end

@implementation REConfigurationsManager

#pragma mark - Class Methods

+ (instancetype)sharedManager
{
    static REConfigurationsManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark - Instance Methods

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _settings = [NSDictionary dictionary];
        [self loadJSON];
    }
    return self;
}

- (void)loadJSON
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kJSONFileName ofType:@"json"];
    
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    self.settings = data[kSettingsKey];
    
    if (error)
    {
        NSLog(@"Error in JSON serialization");
    }
}

#pragma mark - Parse Settings

- (CGFloat)backgroundFadeAmount
{
    return [self.settings[kBackgroundFadeAmountKey] floatValue];
}

- (BOOL)liveBlur
{
    return [self.settings[kLiveBlurKey] boolValue];
}

- (UIColor *)blurTintColor
{
    NSDictionary *blurTintColor = self.settings[kBlurTintColorKey];
    NSString *hexColor = blurTintColor[kHexColorKey];
    CGFloat alpha = [blurTintColor[kAlphaKey] floatValue];
    
    return [UIColor re_colorFromHexString:hexColor alpha:alpha];
}

- (CGFloat)blurRadius
{
    return [self.settings[kBlurRadiusKey] floatValue];
}

- (CGFloat)blurSaturationDeltaFactor
{
    return [self.settings[kBlurSaturationDeltaFactorKey] floatValue];
}

- (NSTimeInterval)animationDuration
{
    return [self.settings[kAnimationDurationKey] floatValue];
}

- (BOOL)limitMenuViewSize
{
    return [self.settings[kLimitMenuViewSizeKey] boolValue];
}

- (CGSize)menuViewSize
{
    NSDictionary *menuViewSizeDict = self.settings[kMenuViewSizeKey];
    
    if (menuViewSizeDict)
    {
        CGFloat width = [menuViewSizeDict[kMenuViewSizeWidthKey] floatValue];
        CGFloat height = [menuViewSizeDict[kMenuViewSizeHeightKey] floatValue];
        
        return CGSizeMake(width, height);;
    }
    
    return CGSizeZero;
}

- (REFrostedViewControllerLiveBackgroundStyle)liveBlurBackgroundStyle
{
    NSString *lifeBlurBackgroundStyleStr = self.settings[@"liveBlurBackgroundStyle"];
    
    if ([lifeBlurBackgroundStyleStr isEqualToString:kLiveBlurBackgroundStyleLightValue]){
        return REFrostedViewControllerLiveBackgroundStyleLight;
    }
    else if ([lifeBlurBackgroundStyleStr isEqualToString:kLiveBlurBackgroundStyleDarkValue])
    {
        return REFrostedViewControllerLiveBackgroundStyleDark;
    }
    
    [NSException raise:@"Execution exception" format:@"Shouldn't be here"];

    return -1;
}

- (REFrostedViewControllerDirection)direction
{
    NSDictionary *options = @{kFrostedViewControllerDirectionLeftKey: @(REFrostedViewControllerDirectionLeft),
                              kFrostedViewControllerDirectionRightKey: @(REFrostedViewControllerDirectionRight),
                              kFrostedViewControllerDirectionTopKey: @(REFrostedViewControllerDirectionTop),
                              kFrostedViewControllerDirectionBottomKey: @(REFrostedViewControllerDirectionBottom)
                              };
    
    NSString *settingsValue = self.settings[kFrostedViewControllerDirectionKey];
    
    return [options[settingsValue] integerValue];
}

@end
