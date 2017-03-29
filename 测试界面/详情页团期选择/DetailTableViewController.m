
//
//  DetailTableViewController.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "DetailTableViewController.h"
#import "TourDepartureDateAndTouristsPresentor.h"
#import "RouteCjyDetailBaseViewModel.h"

@interface DetailTableViewController ()
@property (nonatomic, strong) TourDepartureDateAndTouristsPresentor *presentor;
@end

static NSString *ReuseID = @"reuseIdentifier";

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    self.presentor = [TourDepartureDateAndTouristsPresentor presentorWithTableView:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RouteCjyDetailBaseViewModel *viewModel = [self.presentor.viewModels objectAtIndex:indexPath.row];
    UITableViewCell *cell = [viewModel tableView:tableView cellForRowAtIndexPath:indexPath delegate:self];
    if (!cell) {
        NSLog(@"这里要崩溃了！");
    }
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteCjyDetailBaseViewModel *viewModel = [self.presentor.viewModels objectAtIndex:indexPath.row];
    
    return viewModel.cellHeight;
}

@end
