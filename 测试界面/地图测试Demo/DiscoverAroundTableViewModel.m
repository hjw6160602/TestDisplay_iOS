//
//  DiscoverAroundTableViewModel.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/5/7.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "DiscoverAroundTableViewModel.h"

@interface DiscoverAroundTableViewModel()

@end

@implementation DiscoverAroundTableViewModel

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end
