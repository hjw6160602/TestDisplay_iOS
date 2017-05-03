//
//  B.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/5/3.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "A.h"
#import "B.h"
#import "C.h"

@implementation B

- (instancetype)init {
    if (self = [super init]) {
        self.a = [A new];
        self.c = [C new];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

@end
