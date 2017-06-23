//
//  CustomViewController.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/6/23.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"data - %zd", indexPath.row];
    return cell;
}

//设cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.userInteractionEnabled = YES;
    }
    return _tableView;
}



@end
