//
//  DiscoverAroundListView.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/5/7.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "DiscoverAroundListView.h"
#import "DiscoverAroundTableViewModel.h"

@interface DiscoverAroundListView()
/** */
@property (nonatomic, strong) UIView *headerView;
/** */
@property (nonatomic, strong) UITableView *tableView;
/** */
@property (nonatomic, strong) DiscoverAroundTableViewModel *tableViewModel;

@end

@implementation DiscoverAroundListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.headerView];
    [self addSubview:self.tableView];
}

- (UIView *)headerView {
    if (!_headerView) {
        self.headerView = [[UIView alloc] init];
        self.headerView.frame = CGRectMake(0, 0, 375, 50);
        
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] init];
        self.tableViewModel = [[DiscoverAroundTableViewModel alloc] init];
        _tableView.dataSource = self.tableViewModel;
        _tableView.dataSource = self.tableViewModel;
        _tableView.frame = CGRectMake(0, 50, 475, 500);
        
    }
    return _tableView;
}

@end
