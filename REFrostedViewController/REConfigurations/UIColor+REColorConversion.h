//
//  UIColor+REColorConversion.h
//  REFrostedViewControllerExample
//
//  Created by Alexis Santos Pérez on 27/12/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (REColorConversion)

+ (UIColor *)re_colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)re_colorFromHexString:(NSString *)hexString;

@end
