
//
//  DetailTableViewController.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

static NSString *ReuseID = @"reuseIdentifier";

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseID];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseID forIndexPath:indexPath];
    
    return cell;
}
@end
