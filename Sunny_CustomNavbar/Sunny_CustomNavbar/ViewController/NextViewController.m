//
//  NextViewController.m
//  Sunny_CustomNavbar
//
//  Created by bfec on 17/4/21.
//  Copyright © 2017年 com. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+NavigationBar.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"nextvc";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navBarAlpha = 1.0;
    self.navBarTransparent = NO;
    self.navBarTintColor = [UIColor blackColor];
    self.navBarBackgroundColor = [UIColor orangeColor];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
