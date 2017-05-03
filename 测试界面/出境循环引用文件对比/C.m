//
//  C.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/5/3.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "A.h"
#import "B.h"
#import "C.h"

@implementation C

- (void)dealloc {
    NSLog(@"%@",self.a);
    NSLog(@"%@",self.b);
    NSLog(@"%s", __FUNCTION__);
}

@end
