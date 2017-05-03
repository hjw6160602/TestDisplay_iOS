//
//  A.h
//  测试界面
//
//  Created by 贺嘉炜 on 2017/5/3.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@class B, C;

@interface A : NSObject

@property (nonatomic, weak) B *b;

@property (nonatomic, weak) C *c;

@end
