//
//  Manager.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/5/3.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "Manager.h"
#import "A.h"
#import "B.h"
#import "C.h"

@implementation Manager

- (instancetype)init {
    if (self = [super init]) {
        self.a = [A new];
        self.b = [B new];
        self.c = [C new];
        
        self.a.b = self.b;
        self.a.c = self.c;
        
        self.b.a = self.a;
        self.b.c = self.c;
        
        self.c.a = self.a;
        self.c.b = self.b;

    }
    return self;
}




- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

@end
