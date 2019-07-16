//
//  ViewController.m
//  渐变色View
//
//  Created by SaiDiCaprio on 2019/7/16.
//  Copyright © 2019 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "QXGradientView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor purpleColor];
    QXGradientView *view = [[QXGradientView alloc] initWithFrame:CGRectMake(10, 486, 254, 46)];
    [self.view addSubview:view];
    
    


}


@end
