//
//  B.h
//  测试界面
//
//  Created by 贺嘉炜 on 2017/5/3.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@class A, C;

@interface B : NSObject

@property (nonatomic, weak) A *a;

@property (nonatomic, weak) C *c;

@end
