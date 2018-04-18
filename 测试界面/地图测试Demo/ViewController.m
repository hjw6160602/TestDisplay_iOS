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
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
//2点之间的线路
@property (assign, nonatomic) CLLocationCoordinate2D fromCoordinate;
@property (assign, nonatomic) CLLocationCoordinate2D toCoordinate;
//计算2点之间的距离b
@property (assign, nonatomic) CLLocation *currentLocation;
@property (assign, nonatomic) CLLocation *oldLocation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化地图
    [self initWithMapView];
    //初始化定位服务管理对象
    [self initWithLocationManager];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //开始定位
    [self.locationManager startUpdatingLocation];
//    _txtQueryKey.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.locationManager.delegate = nil;
//    _txtQueryKey.delegate = nil;
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)initWithMapView {
    //设置地图类型
    self.mapView.mapType = MKMapTypeStandard;
    //设置代理
    self.mapView.delegate = self;
    //开启自动定位
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
}

- (void)initWithLocationManager {
    //初始化定位服务管理对象
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    //设置精确度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置设备移动后获取位置信息的最小距离。单位为米
    self.locationManager.distanceFilter = 10.0f;
}

//位置的实时更新
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.fromCoordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    //    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);//这个显示大小精度自己调整
    //    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    //    [mapView setRegion:region animated:YES];
    
    CLLocation *locNow = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locNow completionHandler:^(NSArray *placemarks,NSError *error)
     {
         CLPlacemark *placemark=[placemarks objectAtIndex:0];
         self.oldLocation = placemark.location;
         CLLocationCoordinate2D coordinate;
         coordinate.latitude = userLocation.location.coordinate.latitude;
         coordinate.longitude = userLocation.location.coordinate.longitude;
         MyAnnotation *annotation = [[MyAnnotation alloc] init];
         //设置中心
         annotation.coordinate = coordinate;
         //触发viewForAnnotation
         
         //设置显示范围
         MKCoordinateRegion region;
         region.span.latitudeDelta = 0.011111;
         region.span.longitudeDelta = 0.011111;
         region.center = coordinate;
         // 设置显示位置(动画)
         [self.mapView setRegion:region animated:YES];
         // 设置地图显示的类型及根据范围进行显示
         [self.mapView regionThatFits:region];
         self.mapView.showsUserLocation = NO;
         annotation.myTitle = @"我的位置";
         annotation.mySubtitle = [NSString stringWithFormat:@"%@, %@, %@",placemark.locality,placemark.administrativeArea,placemark.thoroughfare];
         annotation.coordinate = placemark.location.coordinate;
         [self.mapView addAnnotation:annotation];
     }];
}

//线路的绘制
- (IBAction)lineDrawing:(id)sender {
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

//线路的绘制
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer;
    renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.lineWidth = 5.0;
    renderer.strokeColor = [UIColor purpleColor];
    
    return renderer;
}

//地理信息编码查询
//- (IBAction)handleButtonAction:(id)sender {
//    self.mapView.showsUserLocation = NO;
//    
//    self.currentLocation = placemark.location;
//    self.toCoordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
//    //调整地图位置和缩放比例
//    //第一个参数指定目标区域的中心点，第二个参数是目标区域的南北跨度，单位为米。第三个参数为目标区域东西跨度，单位为米。后2个参数的调整会影响地图的缩放
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 600, 600);
//    //重新设置地图视图的显示区域
//    [self.mapView setRegion:viewRegion animated:YES];
//    //实例化MyAnnotation对象
//    MyAnnotation *annotation = [[MyAnnotation alloc] init];
//    //将地标CLPlacemark对象取出，放入到MyAnnotation对象中
//    annotation.myTitle = placemark.locality;
//    annotation.mySubtitle = [NSString stringWithFormat:@"%@, %@, %@",placemark.locality,placemark.administrativeArea,placemark.thoroughfare];
//    annotation.coordinate = placemark.location.coordinate;
//    
//    //把标注点MyAnnotation对象添加到地图上
//    [self.mapView addAnnotation:annotation];
//}

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

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

@end
