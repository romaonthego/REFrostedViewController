//
// REFrostedContainerViewController.m
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

#import "REFrostedContainerViewController.h"
#import "UIImage+REFrostedViewController.h"
#import "UIView+REFrostedViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "RECommonFunctions.h"

@interface REFrostedContainerViewController ()

@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (strong, readwrite, nonatomic) NSMutableArray *backgroundViews;
@property (strong, readwrite, nonatomic) UIView *containerView;
@property (assign, readwrite, nonatomic) CGPoint containerOrigin;

@end

@interface REFrostedViewController ()

@property (assign, readwrite, nonatomic) BOOL visible;
@property (assign, readwrite, nonatomic) CGSize calculatedMenuViewSize;

@end

@implementation REFrostedContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.0f;
        [self.view addSubview:backgroundView];
        [self.backgroundViews addObject:backgroundView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
        [backgroundView addGestureRecognizer:tapRecognizer];
    }
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, self.view.frame.size.height)];
    self.containerView.clipsToBounds = YES;
    [self.view addSubview:self.containerView];
    
    if (self.frostedViewController.liveBlur) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toolbar.barStyle = (UIBarStyle)self.frostedViewController.liveBlurBackgroundStyle;
        if ([toolbar respondsToSelector:@selector(setBarTintColor:)])
            [toolbar performSelector:@selector(setBarTintColor:) withObject:self.frostedViewController.blurTintColor];
        [self.containerView addSubview:toolbar];

    } else {
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.containerView addSubview:self.backgroundImageView];
    }
    
    if (self.frostedViewController.menuViewController) {
        [self addChildViewController:self.frostedViewController.menuViewController];
        self.frostedViewController.menuViewController.view.frame = self.containerView.bounds;
        [self.containerView addSubview:self.frostedViewController.menuViewController.view];
        [self.frostedViewController.menuViewController didMoveToParentViewController:self];
    }
    
    [self.view addGestureRecognizer:self.frostedViewController.panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.backgroundImageView.image = self.screenshotImage;
    self.backgroundImageView.frame = self.view.bounds;
    self.frostedViewController.menuViewController.view.frame = self.containerView.bounds;
    
    if (self.animateApperance) {
        CGRect frame = CGRectZero;
        switch (self.frostedViewController.direction) {
            case REFrostedViewControllerDirectionLeft:
                frame = CGRectMake(- self.frostedViewController.calculatedMenuViewSize.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
                break;
            case REFrostedViewControllerDirectionRight:
                frame = CGRectMake(self.view.frame.size.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
                break;
            case REFrostedViewControllerDirectionTop:
                frame = CGRectMake(0, -self.frostedViewController.calculatedMenuViewSize.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
                break;
            case REFrostedViewControllerDirectionBottom:
                frame = CGRectMake(0, self.view.frame.size.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
                break;
            default:
                break;
        }
        [self setContainerFrame:frame];
        [self show];
    }
}

- (void)setContainerFrame:(CGRect)frame
{
    UIView *leftBackgroundView = self.backgroundViews[0];
    UIView *topBackgroundView = self.backgroundViews[1];
    UIView *bottomBackgroundView = self.backgroundViews[2];
    UIView *rightBackgroundView = self.backgroundViews[3];
    
    leftBackgroundView.frame = CGRectMake(0, 0, frame.origin.x, self.view.frame.size.height);
    rightBackgroundView.frame = CGRectMake(frame.size.width + frame.origin.x, 0, self.view.frame.size.width - frame.size.width - frame.origin.x, self.view.frame.size.height);
    
    topBackgroundView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
    bottomBackgroundView.frame = CGRectMake(frame.origin.x, frame.size.height + frame.origin.y, frame.size.width, self.view.frame.size.height);
    
    self.containerView.frame = frame;
    self.backgroundImageView.frame = CGRectMake(- frame.origin.x, - frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)setBackgroundViewsAlpha:(CGFloat)alpha
{
    for (UIView *view in self.backgroundViews) {
        view.alpha = alpha;
    }
}

- (void)resizeToSize:(CGSize)size
{
    CGRect frame = CGRectZero;
    switch (self.frostedViewController.direction) {
        case REFrostedViewControllerDirectionLeft:
            frame = CGRectMake(0, 0, size.width, size.height);
            break;
        case REFrostedViewControllerDirectionRight:
            frame = CGRectMake(self.view.frame.size.width - size.width, 0, size.width, size.height);
            break;
        case REFrostedViewControllerDirectionTop:
            frame = CGRectMake(0, 0, size.width, size.height);
            break;
        case REFrostedViewControllerDirectionBottom:
            frame = CGRectMake(0, self.view.frame.size.height - size.height, size.width, size.height);
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:self.frostedViewController.animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setContainerFrame:frame];
                         [self setBackgroundViewsAlpha:self.frostedViewController.backgroundFadeAmount];
                     }
                     completion:nil];
}

- (void)show
{
    [self showWithVelocity:self.frostedViewController.menuVelocity];
}

- (void)showWithVelocity:(CGFloat)velocity
{
    void (^completionHandler)(BOOL finished) = ^(BOOL finished) {
        if ([self.frostedViewController.delegate conformsToProtocol:@protocol(REFrostedViewControllerDelegate)] && [self.frostedViewController.delegate respondsToSelector:@selector(frostedViewController:didShowMenuViewController:)]) {
            [self.frostedViewController.delegate frostedViewController:self.frostedViewController didShowMenuViewController:self.frostedViewController.menuViewController];
        }
    };
    
    CGRect oldFrame = self.containerView.frame;
    CGRect newFrame = CGRectZero;
    CGFloat distance = 0;
    switch (self.frostedViewController.direction) {
        case REFrostedViewControllerDirectionLeft:
            newFrame = CGRectMake(0, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS((CGRectGetMinX(oldFrame) - CGRectGetMinX(newFrame)) - (CGRectGetWidth(oldFrame) - CGRectGetWidth(newFrame)));
            break;
        case REFrostedViewControllerDirectionRight:
            newFrame = CGRectMake(self.view.frame.size.width - self.frostedViewController.calculatedMenuViewSize.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS((CGRectGetMinX(oldFrame) - CGRectGetMinX(newFrame)) - (CGRectGetWidth(oldFrame) - CGRectGetWidth(newFrame)));
            break;
        case REFrostedViewControllerDirectionTop:
            newFrame = CGRectMake(0, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS((CGRectGetMinY(oldFrame) - CGRectGetMinY(newFrame)) - (CGRectGetHeight(oldFrame) - CGRectGetHeight(newFrame)));
            break;
        case REFrostedViewControllerDirectionBottom:
            newFrame = CGRectMake(0, self.view.frame.size.height - self.frostedViewController.calculatedMenuViewSize.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS((CGRectGetMinY(oldFrame) - CGRectGetMinY(newFrame)) - (CGRectGetHeight(oldFrame) - CGRectGetHeight(newFrame)));
            break;
        default:
            break;
    }
    
    NSTimeInterval animationDuration = MAX(distance/ABS(velocity), 0.05);
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setContainerFrame:newFrame];
                         [self setBackgroundViewsAlpha:self.frostedViewController.backgroundFadeAmount];
                     }
                     completion:completionHandler];
}

- (void)hide
{
    [self hideWithVelocity:self.frostedViewController.menuVelocity];
}


- (void)hideWithVelocity:(CGFloat)velocity
{
	[self hideWithVelocity:velocity completionHandler:nil];
}

- (void)hideWithCompletionHandler:(void(^)(void))completionHandler
{
    [self hideWithVelocity:self.frostedViewController.menuVelocity completionHandler:completionHandler];
}

- (void)hideWithVelocity:(CGFloat)velocity completionHandler:(void(^)(void))completionHandler
{
    void (^completionHandlerBlock)(void) = ^{
        if ([self.frostedViewController.delegate conformsToProtocol:@protocol(REFrostedViewControllerDelegate)] && [self.frostedViewController.delegate respondsToSelector:@selector(frostedViewController:didHideMenuViewController:)]) {
            [self.frostedViewController.delegate frostedViewController:self.frostedViewController didHideMenuViewController:self.frostedViewController.menuViewController];
        }
        if (completionHandler)
            completionHandler();
    };
    
    if ([self.frostedViewController.delegate conformsToProtocol:@protocol(REFrostedViewControllerDelegate)] && [self.frostedViewController.delegate respondsToSelector:@selector(frostedViewController:willHideMenuViewController:)]) {
        [self.frostedViewController.delegate frostedViewController:self.frostedViewController willHideMenuViewController:self.frostedViewController.menuViewController];
    }
    
    CGRect oldFrame = self.containerView.frame;
    CGRect newFrame = CGRectZero;
    CGFloat distance = 0;
    switch (self.frostedViewController.direction) {
        case REFrostedViewControllerDirectionLeft:
            newFrame = CGRectMake(- self.frostedViewController.calculatedMenuViewSize.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS(CGRectGetMinX(oldFrame)-newFrame.origin.x);
            break;
        case REFrostedViewControllerDirectionRight:
            newFrame = CGRectMake(self.view.frame.size.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS(CGRectGetMinX(oldFrame)-newFrame.origin.x);
            break;
        case REFrostedViewControllerDirectionTop:
            newFrame = CGRectMake(0, -self.frostedViewController.calculatedMenuViewSize.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS(CGRectGetMinX(oldFrame)-newFrame.origin.y);
            break;
        case REFrostedViewControllerDirectionBottom:
            newFrame = CGRectMake(0, self.view.frame.size.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            distance = ABS(CGRectGetMinX(oldFrame)-newFrame.origin.y);
            break;
        default:
            break;
    }
    
    NSTimeInterval animationDuration = MAX(distance/ABS(velocity), 0.05);
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setContainerFrame:newFrame];
                         [self setBackgroundViewsAlpha:0];
                     } completion:^(BOOL finished) {
                         self.frostedViewController.visible = NO;
                         [self.frostedViewController re_hideController:self];
                         completionHandlerBlock();
                     }];
}

- (void)refreshBackgroundImage
{
    self.backgroundImageView.image = self.screenshotImage;
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    if ([self.frostedViewController.delegate conformsToProtocol:@protocol(REFrostedViewControllerDelegate)] && [self.frostedViewController.delegate respondsToSelector:@selector(frostedViewController:didRecognizePanGesture:)])
        [self.frostedViewController.delegate frostedViewController:self.frostedViewController didRecognizePanGesture:recognizer];
    
    if (!self.frostedViewController.panGestureEnabled)
        return;
    
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.containerOrigin = self.containerView.frame.origin;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.containerView.frame;
        
        switch (self.frostedViewController.direction) {
            case REFrostedViewControllerDirectionLeft: {
                frame.origin.x = self.containerOrigin.x + point.x;
                if (frame.origin.x > 0) {
                    frame.origin.x = 0;
                    
                    if (!self.frostedViewController.limitMenuViewSize) {
                        frame.size.width = self.frostedViewController.calculatedMenuViewSize.width + self.containerOrigin.x + point.x;
                        if (frame.size.width > self.view.frame.size.width)
                            frame.size.width = self.view.frame.size.width;
                    }
                }
            }
                break;
            case REFrostedViewControllerDirectionRight: {
                frame.origin.x = self.containerOrigin.x + point.x;
                if (frame.origin.x < self.view.frame.size.width - self.frostedViewController.calculatedMenuViewSize.width) {
                    frame.origin.x = self.view.frame.size.width - self.frostedViewController.calculatedMenuViewSize.width;
                    
                    if (!self.frostedViewController.limitMenuViewSize) {
                        frame.origin.x = self.containerOrigin.x + point.x;
                        if (frame.origin.x < 0)
                            frame.origin.x = 0;
                        frame.size.width = self.view.frame.size.width - frame.origin.x;
                    }
                }
            }
                break;
            case REFrostedViewControllerDirectionTop: {
                frame.origin.y = self.containerOrigin.y + point.y;
                if (frame.origin.y > 0) {
                    frame.origin.y = 0;
                    
                    if (!self.frostedViewController.limitMenuViewSize) {
                        frame.size.height = self.frostedViewController.calculatedMenuViewSize.height + self.containerOrigin.y + point.y;
                        if (frame.size.height > self.view.frame.size.height)
                            frame.size.height = self.view.frame.size.height;
                    }
                }
            }
                break;
            case REFrostedViewControllerDirectionBottom: {
                frame.origin.y = self.containerOrigin.y + point.y;
                if (frame.origin.y < self.view.frame.size.height - self.frostedViewController.calculatedMenuViewSize.height) {
                    frame.origin.y = self.view.frame.size.height - self.frostedViewController.calculatedMenuViewSize.height;
                    
                    if (!self.frostedViewController.limitMenuViewSize) {
                        frame.origin.y = self.containerOrigin.y + point.y;
                        if (frame.origin.y < 0)
                            frame.origin.y = 0;
                        frame.size.height = self.view.frame.size.height - frame.origin.y;
                    }
                }
            }
                break;
            default:
                break;
        }
        
        [self setContainerFrame:frame];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat gestureVelocityY = MAX(ABS(velocity.y), 400);
        CGFloat gestureVelocityX = MAX(ABS(velocity.x), 400);
        switch (self.frostedViewController.direction) {
            case REFrostedViewControllerDirectionLeft:
            case REFrostedViewControllerDirectionRight: {
                if ([recognizer velocityInView:self.view].x < 0) {
                    [self hideWithVelocity:gestureVelocityX];
                } else {
                    [self showWithVelocity:gestureVelocityX];
                }
            }
                break;
            case REFrostedViewControllerDirectionTop:
            case REFrostedViewControllerDirectionBottom: {
                if ([recognizer velocityInView:self.view].y < 0) {
                    [self showWithVelocity:gestureVelocityY];
                } else {
                    [self hideWithVelocity:gestureVelocityY];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)fixLayoutWithDuration:(NSTimeInterval)duration
{
    CGRect frame = CGRectZero;
    switch (self.frostedViewController.direction) {
        case REFrostedViewControllerDirectionLeft:
            frame = CGRectMake(0, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            break;
        case REFrostedViewControllerDirectionRight:
            frame = CGRectMake(self.view.frame.size.width - self.frostedViewController.calculatedMenuViewSize.width, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            break;
        case REFrostedViewControllerDirectionTop:
            frame = CGRectMake(0, 0, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            break;
        case REFrostedViewControllerDirectionBottom:
            frame = CGRectMake(0, self.view.frame.size.height - self.frostedViewController.calculatedMenuViewSize.height, self.frostedViewController.calculatedMenuViewSize.width, self.frostedViewController.calculatedMenuViewSize.height);
            break;
        default:
            break;
    }
    [self setContainerFrame:frame];
    [self setBackgroundViewsAlpha:self.frostedViewController.backgroundFadeAmount];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self fixLayoutWithDuration:duration];
}

@end
