//
//  HotelAroundMapViewController.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/5/8.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "HotelAroundMapViewController.h"
#import "MyAnnotation.h"

@import MapKit;
@import CoreLocation;

@interface HotelAroundMapViewController()<MKMapViewDelegate, CLLocationManagerDelegate>
/** 主地图 */
@property (strong, nonatomic) MKMapView *mapView;
/** 位置管理者 */
@property (strong, nonatomic) CLLocationManager *locationManager;
/** 起始点坐标（当前位置）*/
@property (assign, nonatomic) CLLocationCoordinate2D fromCoordinate;
/** 终点坐标（酒店位置）*/
@property (assign, nonatomic) CLLocationCoordinate2D toCoordinate;
/** 路径规划方式 */
@property (assign, nonatomic) MKDirectionsTransportType transportType;
/*
 typedef NS_OPTIONS(NSUInteger, MKDirectionsTransportType) {
 MKDirectionsTransportTypeAutomobile = 1 << 0,
 MKDirectionsTransportTypeWalking = 1 << 1,
 }
 */
@end

@implementation HotelAroundMapViewController

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.locationManager.delegate = nil;
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Init

- (void)initData {
    self.fromCoordinate = CLLocationCoordinate2DMake(31.263743,121.398443);
    self.toCoordinate = CLLocationCoordinate2DMake(31.236086,121.391758);
}

- (void)initUI {
    [self.view addSubview:self.mapView];
    
    self.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirectionsRequest *request = [self setupDirectionsRequest];
    [self calculateDirectionsWithRequest:request];
}


#pragma mark - Actions
- (MKDirectionsRequest *)setupDirectionsRequest{
    // 根据经纬度信息创建MKPlacemark对象
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.fromCoordinate addressDictionary:nil];
    MKPlacemark *toPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.toCoordinate addressDictionary:nil];
    
    // 根据起点和终点的Placemark对象撞见对应的mapItem对象
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    
    // 根据起点和终点的mapItem对象撞见DirectionRequest请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = fromItem;
    request.destination = toItem;
    return request;
}

//线路的绘制
- (void)calculateDirectionsWithRequest:(MKDirectionsRequest *)request {
    request.transportType = self.transportType;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            MKRoute *route = response.routes[0];
            [self.mapView addOverlay:route.polyline];
            NSInteger intervalInt = (NSInteger)route.expectedTravelTime;
            NSInteger minute = intervalInt /60;
            NSString *expectedTravelTime = [NSString stringWithFormat:@"%02ld分钟", minute];
            CGFloat distance = route.distance / 1000;
            NSLog(@"distance: %.2f公里 expectedTravelTime:%@", distance, expectedTravelTime);
        }
        else {
            NSLog(@"error:%@", error);
        }
    }];
    
    //    [directions calculateETAWithCompletionHandler:^(MKETAResponse * response, NSError * error) {
    //        if (!error) {
    //            NSTimeInterval expectedTravelTime = response.expectedTravelTime;
    //            NSLog(@"expectedTravelTime:%f", expectedTravelTime);
    //        } else {
    //            NSLog(@"error:%@", error);
    //        }
    //    }];
}

#pragma mark - MKMapViewDelegate
//位置的实时更新
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.fromCoordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

//线路的绘制
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        render.strokeColor = [UIColor blueColor];
        render.lineWidth = 3.0;
        return render;
    }
    return nil;
}

//在地图视图添加标注时回调
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MyAnnotation *)annotation {
//    MKPinAnnotationView *ann = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
//    if (ann == nil) {
//        ann = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
//    }
//    ann.pinColor = MKPinAnnotationColorPurple;
//    ann.animatesDrop = YES;
//    ann.canShowCallout = YES;
//
//    return ann;
//}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未决定");
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"已经定位");
}

#pragma mark - Lazy load
- (MKMapView *)mapView {
    if (!_mapView) {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [_mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
        _mapView.centerCoordinate = self.fromCoordinate;
        CLLocationCoordinate2D center = self.fromCoordinate;
        MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);//这个显示大小精度自己调整
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [_mapView setRegion:region animated:YES];
    }
    return _mapView;
}

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        // 实例化位置管理者
        _locationManager = [[CLLocationManager alloc] init];
        // 指定代理,代理中获取位置数据
        _locationManager.delegate = self;
        // 前台定位授权 官方文档中说明info.plist中必须有NSLocationWhenInUseUsageDescription键
        [_locationManager requestWhenInUseAuthorization];
        // 前后台定位授权 官方文档中说明info.plist中必须有NSLocationAlwaysUsageDescription键
        [_locationManager requestAlwaysAuthorization];
        //设置精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置设备移动后获取位置信息的最小距离。单位为米
        _locationManager.distanceFilter = 10.0f;
    }
    return _locationManager;
}

@end
