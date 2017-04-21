//
//  UINavigationController+NavigationBar.m
//  WDK-iOS-framwork
//
//  Created by bfec on 17/4/21.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UINavigationController+NavigationBar.h"
#import "UIViewController+NavigationBar.h"

@implementation UINavigationController (NavigationBar)

+ (void)initialize
{
    if (self == [UINavigationController class])
    {
        [self exchangeMethod:@"_updateInteractiveTransition:" replaceMethod:@"et_updateInteractiveTransition:"];
        [self exchangeMethod:@"popViewControllerAnimated:" replaceMethod:@"et_popViewControllerAnimated:"];
        [self exchangeMethod:@"popToRootViewControllerAnimated:" replaceMethod:@"et_popToRootViewControllerAnimated:"];
    }
}

+ (void)exchangeMethod:(NSString *)orignMethod replaceMethod:(NSString *)replaceMethod
{
    Method m1 = class_getInstanceMethod(self, NSSelectorFromString(orignMethod));
    Method m2 = class_getInstanceMethod(self, NSSelectorFromString(replaceMethod));
    method_exchangeImplementations(m1, m2);
}

- (void)et_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *topVC = self.topViewController;
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = topVC.transitionCoordinator;
    
    if (topVC && transitionCoordinator)
    {
        UIViewController *fromVC = [transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        
        [self _updateNavBarAlpha:fromVC toVC:toVC percentComplete:percentComplete];
        [self _updateNavBarTintColor:fromVC toVC:toVC percentComplete:percentComplete];
        [self _updateNavBarBackgroundColor:fromVC toVC:toVC percentComplete:percentComplete];
        
        __weak UINavigationController *weakS = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
        {
            [transitionCoordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                if ([context isCancelled])
                {
                    [weakS _updateNavBar:fromVC];
                }
                else
                {
                    [weakS _updateNavBar:toVC];
                }
            }];
        }
        else
        {
            [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                if ([context isCancelled])
                {
                    [weakS _updateNavBar:fromVC];
                }
                else
                {
                    [weakS _updateNavBar:toVC];
                }
            }];
        }
    }
    
    [self et_updateInteractiveTransition:percentComplete];
}

- (void)et_popViewControllerAnimated:(BOOL)animation
{
    UIViewController *fromVC = self.topViewController;
    NSInteger index = [self.viewControllers indexOfObject:fromVC];
    if (index > 0)
    {
        __weak UIViewController *toVC = [self.viewControllers objectAtIndex:index - 1];
        __weak UINavigationController *weakS = self;
        [UIView animateWithDuration:0.35 animations:^{
            [weakS _updateNavBar:toVC];
        }];
    }
    [self et_popViewControllerAnimated:animation];
}

- (void)et_popToRootViewControllerAnimated:(BOOL)animation
{
    NSInteger count = [self.viewControllers count];
    if (count >= 0)
    {
        __weak UIViewController *toVC = [self.viewControllers objectAtIndex:0];
        __weak UINavigationController *weakS = self;
        [UIView animateWithDuration:0.35 animations:^{
            [weakS _updateNavBar:toVC];
        }];
    }
    
    [self et_popToRootViewControllerAnimated:animation];
}

- (void)_updateNavBar:(UIViewController *)toVC
{
    [self setTintColor:toVC.navBarTintColor];
    [self setTransparentAlpha:toVC.navBarAlpha];
    [self setTransparent:toVC.navBarTransparent];
    [self setBackgroundColor:toVC.navBarBackgroundColor];
}

- (void)_updateNavBarAlpha:(UIViewController *)fromVC toVC:(UIViewController *)toVC percentComplete:(CGFloat)percentComplete
{
    CGFloat fromVCAlpha = fromVC.navBarAlpha;
    CGFloat toVCAlpha = toVC.navBarAlpha;
    CGFloat nowVCAlpha = (toVCAlpha - fromVCAlpha) * percentComplete + fromVCAlpha;
    [self setTransparentAlpha:nowVCAlpha];
}

- (void)_updateNavBarTintColor:(UIViewController *)fromVC toVC:(UIViewController *)toVC percentComplete:(CGFloat)percentComplete
{
    UIColor *fromColor = fromVC.navBarTintColor;
    UIColor *toColor = toVC.navBarTintColor;
    UIColor *nowColor = [self _getColor:fromColor toColor:toColor percentComplete:percentComplete];
    [self setTintColor:nowColor];
}

- (void)_updateNavBarBackgroundColor:(UIViewController *)fromVC toVC:(UIViewController *)toVC percentComplete:(CGFloat)percentComplete
{
    UIColor *fromColor = fromVC.navBarBackgroundColor;
    UIColor *toColor = toVC.navBarBackgroundColor;
    UIColor *nowColor = [self _getColor:fromColor toColor:toColor percentComplete:percentComplete];
    [self setBackgroundColor:nowColor];
}

- (UIColor *)_getColor:(UIColor *)fromColor toColor:(UIColor *)toColor percentComplete:(CGFloat)percentComplete
{
    CGFloat fromRed;
    CGFloat fromGreen;
    CGFloat fromBlue;
    CGFloat fromAlpha;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed;
    CGFloat toGreen;
    CGFloat toBlue;
    CGFloat toAlpha;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat nowRed = (toRed - fromRed) * percentComplete + fromRed;
    CGFloat nowGreen = (toGreen - fromGreen) * percentComplete + fromGreen;
    CGFloat nowBlue = (toBlue - fromBlue) * percentComplete + fromBlue;
    CGFloat nowAlpha = (toAlpha - fromAlpha) * percentComplete + fromAlpha;
    
    UIColor *nowColor = [UIColor colorWithRed:nowRed green:nowGreen blue:nowBlue alpha:nowAlpha];
    return nowColor;
}

- (void)setTransparent:(BOOL)transparent
{
    if (transparent)
    {
        self.navigationBar.alpha = 0.0;
    }
    else
    {
        self.navigationBar.alpha = 1.0;
    }
}

- (void)setTransparentAlpha:(CGFloat)transparentAlpha
{
    UIView *backgroudView = [self.navigationBar.subviews objectAtIndex:0];
    backgroudView.alpha = transparentAlpha;
}

- (void)setTintColor:(UIColor *)tintColor
{
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:tintColor ?: [UIColor whiteColor]};
    self.navigationBar.tintColor = tintColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    UIView *backgroudView = self.navigationBar.subviews[0];
    
    for (UIView *subView in backgroudView.subviews)
    {
        if ([subView isKindOfClass:[UIVisualEffectView class]] || [subView isKindOfClass:NSClassFromString(@"_UIBackdropView")])
        {
            [subView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        subView.backgroundColor = backgroundColor;
    }
}

@end
































