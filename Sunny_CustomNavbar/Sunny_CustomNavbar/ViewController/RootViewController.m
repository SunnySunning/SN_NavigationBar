//
//  RootViewController.m
//  Sunny_CustomNavbar
//
//  Created by bfec on 17/4/21.
//  Copyright © 2017年 com. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewController+NavigationBar.h"
#import "MJRefreshNormalHeader.h"
#import "NextViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
}

- (void)_initUI
{
    self.navBarAlpha = 0.0;
    self.navBarTransparent = NO;
    self.navBarTintColor = [UIColor whiteColor];
    self.navBarBackgroundColor = [UIColor blueColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"LEFT" style:UIBarButtonItemStylePlain target:self action:@selector(_left:)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"RIGHT" style:UIBarButtonItemStylePlain target:self action:@selector(_right:)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    self.title = @"HOME";

    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 184)];
    tableView.tableHeaderView = headerView;
    headerView.image = [UIImage imageNamed:@"kecheng"];
    
    __weak typeof(self) weakS = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakS _loadMoreData];
    }];
    
    self.tableView = tableView;
}

- (void)_left:(UINavigationItem *)item{}
- (void)_right:(UINavigationItem *)item{}


- (void)_loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (NSMutableArray *)itemArr
{
    if (!_itemArr)
    {
        _itemArr = [NSMutableArray array];
        for (int i = 0; i < 15; i++)
        {
            [_itemArr addObject:@(i)];
        }
    }
    return _itemArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [[self.itemArr objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemArr count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= 64)
    {
        self.navBarTransparent = NO;
        self.navBarAlpha = offsetY / 64.0;
    }
    else if (offsetY > 64)
    {
        self.navBarAlpha = 1.0;
    }
    else if (offsetY < 0)
    {
        self.navBarTransparent = YES;
        self.navBarAlpha = 0.0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end





























