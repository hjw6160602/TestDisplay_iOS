//
//  ViewController.m
//  地图测试Demo
//
//  Created by 贺嘉炜 on 2018/4/18.
//  Copyright © 2018年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"

@import MapKit;
@import CoreLocation;

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
/** 主地图 */
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
/** 位置管理者 */
@property (strong, nonatomic) CLLocationManager *locationManager;
//2点之间的线路
@property (assign, nonatomic) CLLocationCoordinate2D fromCoordinate;
@property (assign, nonatomic) CLLocationCoordinate2D toCoordinate;

@end

@implementation ViewController

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
    self.toCoordinate = CLLocationCoordinate2DMake(31.2360868237,121.3917589188);
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

#pragma mark - MKMapViewDelegate
//位置的实时更新
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.fromCoordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    self.mapView.centerCoordinate = userLocation.location.coordinate;
    [self lineDrawing];
    //    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);//这个显示大小精度自己调整
    //    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    //    [mapView setRegion:region animated:YES];
}

//在地图视图添加标注时回调
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MyAnnotation *)annotation {
    MKPinAnnotationView *ann = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (ann == nil) {
        ann = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    ann.pinColor = MKPinAnnotationColorPurple;
    ann.animatesDrop = YES;
    ann.canShowCallout = YES;
    
    return ann;
}

//线路的绘制
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer;
    renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.lineWidth = 5.0;
    renderer.strokeColor = [UIColor purpleColor];
    
    return renderer;
}

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

#pragma mark - Actions
//线路的绘制
- (void)lineDrawing {
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.fromCoordinate addressDictionary:nil];
    MKPlacemark *toPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.toCoordinate addressDictionary:nil];
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = fromItem;
    request.destination = toItem;
    request.requestsAlternateRoutes = YES;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"error:%@", error);
         }
         else {
             MKRoute *route = response.routes[0];
             [self.mapView addOverlay:route.polyline];
         }
     }];
}

#pragma mark - Lazy load
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
