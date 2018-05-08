//
//  ViewController.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/4/18.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "HotelAroundMapViewController.h"

@implementation ViewController

- (IBAction)btnOnClick:(id)sender {
    [self.navigationController pushViewController:[HotelAroundMapViewController new] animated:YES];
}

@end
