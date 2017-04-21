//
//  UIViewController+NavigationBar.m
//  WDK-iOS-framwork
//
//  Created by bfec on 17/4/19.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UIViewController+NavigationBar.h"
#import "UINavigationController+NavigationBar.h"

static const NSString *vcNavBarAlphaKey;
static const NSString *vcNavBarTransparentKey;
static const NSString *vcNavBarTintColorKey;
static const NSString *vcNavBarBackgroundColorKey;

@implementation UIViewController (NavigationBar)

- (CGFloat)navBarAlpha
{
    CGFloat alphaValue = [objc_getAssociatedObject(self, &vcNavBarAlphaKey) floatValue];
    if (alphaValue <= 1.0 && alphaValue >= 0.0)
    {
        return alphaValue;
    }
    return 1.0;
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha
{
    if (navBarAlpha <= 1.0 && navBarAlpha >= 0.0)
    {
        objc_setAssociatedObject(self, &vcNavBarAlphaKey, @(navBarAlpha), OBJC_ASSOCIATION_RETAIN);
        UINavigationController *nav = self.navigationController;
        [nav setTransparentAlpha:navBarAlpha];
    }
}

- (BOOL)navBarTransparent
{
    return [objc_getAssociatedObject(self, &vcNavBarTransparentKey) boolValue];
}

- (void)setNavBarTransparent:(BOOL)navBarTransparent
{
    objc_setAssociatedObject(self, &vcNavBarTransparentKey, @(navBarTransparent), OBJC_ASSOCIATION_RETAIN);
    UINavigationController *nav = self.navigationController;
    [nav setTransparent:navBarTransparent];
}

- (UIColor *)navBarTintColor
{
    return (UIColor *)objc_getAssociatedObject(self, &vcNavBarTintColorKey);
}

- (void)setNavBarTintColor:(UIColor *)navBarTintColor
{
    objc_setAssociatedObject(self, &vcNavBarTintColorKey, navBarTintColor, OBJC_ASSOCIATION_RETAIN);
    UINavigationController *nav = self.navigationController;
    [nav setTintColor:navBarTintColor];
}

- (UIColor *)navBarBackgroundColor
{
    return (UIColor *)objc_getAssociatedObject(self, &vcNavBarBackgroundColorKey);
}

- (void)setNavBarBackgroundColor:(UIColor *)navBarBackgroundColor
{
    objc_setAssociatedObject(self, &vcNavBarBackgroundColorKey, navBarBackgroundColor, OBJC_ASSOCIATION_RETAIN);
    UINavigationController *nav = self.navigationController;
    [nav setBackgroundColor:navBarBackgroundColor];
}

@end




























