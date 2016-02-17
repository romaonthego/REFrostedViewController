# REFrostedViewController

iOS 7/8 style blurred view controller that appears on top of your view controller.

<img src="https://github.com/romaonthego/REFrostedViewController/raw/master/Screenshot.png" alt="REFrostedViewController Screenshot" width="400" height="568" />
<img src="https://github.com/romaonthego/REFrostedViewController/raw/master/Demo.gif" alt="REFrostedViewController Screenshot" width="320" height="568" />

## Requirements
* Xcode 6 or higher
* Apple LLVM compiler
* iOS 6.0 or higher
* ARC

## Demo

Build and run the `REFrostedViewControllerExample` project in Xcode to see `REFrostedViewController` in action.

## Installation

### CocoaPods

The recommended approach for installating `REFrostedViewController` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.28.0** using Git >= **1.8.0** installed via Homebrew.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add REFrostedViewController:

``` bash
platform :ios, '6.0'
pod 'REFrostedViewController', '~> 2.4'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

Please note that if your installation fails, it may be because you are installing with a version of Git lower than CocoaPods is expecting. Please ensure that you are running Git >= **1.8.0** by executing `git --version`. You can get a full picture of the installation details by executing `pod install --verbose`.

### Manual Install

All you need to do is drop `REFrostedViewController` files into your project, and add `#include "REFrostedViewController.h"` to the top of classes that will use it.

Your project must be linked against the `Accelerate` framework.

## Example Usage

In your AppDelegate's `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions` create the view controller and assign content and menu view controllers.

``` objective-c
// Create content and menu controllers
//
DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[DEMOHomeViewController alloc] init]];
DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];

// Create frosted view controller
//
REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
frostedViewController.direction = REFrostedViewControllerDirectionLeft;

// Make it a root controller
//
self.window.rootViewController = frostedViewController;
```

You can present it manually:

```objective-c
[self.frostedViewController presentMenuViewController];
```

or using a pan gesture recognizer:

```objective-c
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.frostedViewController panGestureRecognized:sender];
}
```

### Live Blur

By default, live blurring is enabled under iOS 7. The live blurring is performed by using a `UIToolbar` as a background view, that means when you change its tint color, it becomes desaturated. That's the way it works on iOS 7. iPhone 4 doesn't support live blur and falls back to a transparent view. This also applies to when a user device has high contrast accessibility setting set to on.
To disable live blurring, set `liveBlur` property to `NO`.

## Storyboards Example

1. Create a subclass of `REFrostedViewController`. In this example we call it `DEMORootViewController`.
2. In the Storyboard designate the root view's owner as `DEMORootViewController`.
3. Make sure to `#import "REFrostedViewController.h"` in `DEMORootViewController.h`.
4. Add more view controllers to your Storyboard, and give them identifiers "menuController" and "contentController". Note that in the new Xcode the identifier is called "Storyboard ID" and can be found in the Identity inspector.
5. Add a method `awakeFromNib` to `DEMORootViewController.m` with the following code:

```objective-c

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
}

```

## Customization

You can customize the following properties of `REFrostedViewController`:

``` objective-c
@property (strong, readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) REFrostedViewControllerDirection direction;
@property (assign, readwrite, nonatomic) CGFloat backgroundFadeAmount;
@property (strong, readwrite, nonatomic) UIColor *blurTintColor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurRadius; // Used only when live blur is off
@property (assign, readwrite, nonatomic) CGFloat blurSaturationDeltaFactor; // Used only when live blur is off
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) BOOL limitMenuViewSize;
@property (assign, readwrite, nonatomic) CGSize menuViewSize;
@property (assign, readwrite, nonatomic) BOOL liveBlur; // iOS 7 only
@property (assign, readwrite, nonatomic) REFrostedViewControllerLiveBackgroundStyle liveBlurBackgroundStyle; // iOS 7 only
```

## Credits

Inspired by a [Dribbble shot](http://dribbble.com/shots/1173945-Menu-Concept-1), author [Jackie Tran](http://dribbble.com/jackietrananh).

The blur algorithm that is used for static blur comes from WWDC 2013's session 208, "What's New in iOS User Interface Design".

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

REFrostedViewController is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
