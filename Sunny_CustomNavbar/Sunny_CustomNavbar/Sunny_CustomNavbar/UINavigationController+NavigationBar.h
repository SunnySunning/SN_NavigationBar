//
//  UINavigationController+NavigationBar.h
//  WDK-iOS-framwork
//
//  Created by bfec on 17/4/21.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UINavigationController (NavigationBar)

- (void)setTransparent:(BOOL)transparent;
- (void)setTransparentAlpha:(CGFloat)transparentAlpha;
- (void)setTintColor:(UIColor *)tintColor;
- (void)setBackgroundColor:(UIColor *)backgroundColor;

@end
