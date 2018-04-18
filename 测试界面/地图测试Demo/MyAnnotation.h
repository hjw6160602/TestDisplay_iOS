//
//  MyAnnotation.h
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/4/18.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@import MapKit;

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic ,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *myTitle;
@property (nonatomic,copy) NSString *mySubtitle;

- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;

@end
