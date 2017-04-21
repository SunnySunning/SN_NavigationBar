//
//  UIViewController+NavigationBar.h
//  WDK-iOS-framwork
//
//  Created by bfec on 17/4/19.
//  Copyright © 2017年 com. All rights reserved.
//
/***********
 *
 *
 *  1.通过给UIViewController添加分类,
 *    使在每个独立的UIViewController中,
 *    可以方便的使用设置属性值的方式,
 *    定制当前UIViewController的背景颜色,透明度等外观展示
 *  2.同时给UINavigationController添加分类,
 *    使在定制UINavigationBar的同时,可以实现pop的时候,按照系统的效果展现
 *
 *
 ***********/

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)

/*
 * 导航栏背景颜色透明度
 */
@property (nonatomic, assign) CGFloat navBarAlpha;

/*
 * 导航栏是否透明(可见)
 */
@property (nonatomic, assign) BOOL navBarTransparent;

/*
 * 导航栏的item的颜色
 */
@property (nonatomic, strong) UIColor *navBarTintColor;

/*
 * 导航栏的背景颜色
 */
@property (nonatomic, strong) UIColor *navBarBackgroundColor;

@end













