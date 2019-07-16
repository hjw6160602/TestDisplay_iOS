//
//  ViewController.m
//  响应链与实践传递
//
//  Created by saidicaprio on 2019/5/10.
//  Copyright © 2019 贺嘉炜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];
    UIGestureRecognizer *rec = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch:)];
    UIApplication
    
    // Do any additional setup after loading the view.
}


@end
