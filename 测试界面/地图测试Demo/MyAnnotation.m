//
//  MyAnnotation.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/4/18.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _myTitle;
}

- (NSString *)subtitle {
    return _mySubtitle;
}
@end

