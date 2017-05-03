//
//  ViewController.m
//  出境循环引用文件对比
//
//  Created by 贺嘉炜 on 2017/4/27.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "Manager.h"

@interface ViewController ()
@property (nonatomic, strong) Manager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[Manager alloc] init];
    
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

@end
