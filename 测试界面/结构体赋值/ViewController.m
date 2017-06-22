//
//  ViewController.m
//  结构体赋值
//
//  Created by 贺嘉炜 on 2017/6/8.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 访问日期：选中的团期信息 */
@property (nonatomic, assign) VisitInfo visitInfo;

@end

typedef struct IFPoint {
    CGFloat x;
    CGFloat y;
}IFPoint;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    const char *specDate = "2017";
    VisitInfo visitInfo = {2, 0, 1, specDate};
    IFPoint point = {0, 0};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
