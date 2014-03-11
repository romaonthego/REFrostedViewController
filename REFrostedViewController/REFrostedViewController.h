//
// REFrostedViewController.h
// REFrostedViewController
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "UIViewController+REFrostedViewController.h"

typedef NS_ENUM(NSInteger, REFrostedViewControllerDirection) {
    REFrostedViewControllerDirectionLeft,
    REFrostedViewControllerDirectionRight,
    REFrostedViewControllerDirectionTop,
    REFrostedViewControllerDirectionBottom
};

typedef NS_ENUM(NSInteger, REFrostedViewControllerLiveBackgroundStyle) {
    REFrostedViewControllerLiveBackgroundStyleLight,
    REFrostedViewControllerLiveBackgroundStyleDark
};

@protocol REFrostedViewControllerDelegate;

@interface REFrostedViewController : UIViewController

@property (strong, readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) REFrostedViewControllerDirection direction;

/**
 * The backgroundFadeAmount is how much the backgound view fades when the menu
 * view is presented.
 *
 * 1.0 is completely black. 0.0 means the background does not dim at all.
 * The default value is 0.3.
 */
@property (assign, readwrite, nonatomic) CGFloat backgroundFadeAmount;
@property (strong, readwrite, nonatomic) UIColor *blurTintColor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurRadius; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurSaturationDeltaFactor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) BOOL limitMenuViewSize;
@property (assign, readwrite, nonatomic) CGSize menuViewSize;
@property (assign, readwrite, nonatomic) BOOL liveBlur; // iOS 7 only
@property (assign, readwrite, nonatomic) REFrostedViewControllerLiveBackgroundStyle liveBlurBackgroundStyle; // iOS 7 only

@property (weak, readwrite, nonatomic) id<REFrostedViewControllerDelegate> delegate;
@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *menuViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController menuViewController:(UIViewController *)menuViewController;
- (void)presentMenuViewController;
- (void)hideMenuViewController;
- (void)resizeMenuViewControllerToSize:(CGSize)size;
- (void)hideMenuViewControllerWithCompletionHandler:(void(^)(void))completionHandler;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end

@protocol REFrostedViewControllerDelegate <NSObject>

@optional
- (void)frostedViewController:(REFrostedViewController *)frostedViewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController;
- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController;

@end