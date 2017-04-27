//
//  RouteCjyDetailController.h
//  Lvmm
//
//  Created by liwancheng on 16/1/12.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import <LvmmBaseClass/BaseViewController.h>
//#import <LvmmBaseClass/EGOMJTableView.h>
//#import <LvmmModel/RouteProduct.h>
#import <LvmmMediator/RouteDetailDelegate.h>


@interface RouteCjyDetailController : BaseViewController

@property (weak, nonatomic) id<RouteDetailDelegate> delegate;;

@property (nonatomic, assign) long long productDestId; // 出发地Id
@property (nonatomic, strong) NSString *selectedDateString;
@property (nonatomic, strong) NSString *tailCode; //推送标示
@property (nonatomic, strong) NSMutableDictionary *allPropDic;

@property (strong, nonatomic) UIWebView *detailWebview;
@property (strong, nonatomic) UIActivityIndicatorView *webLoadIndicatorView;

@property (nonatomic, strong) RouteProduct *routeProduct;

- (void)setObjectsFromRouteProduct;
- (void)updateCollectButtonImage;
- (NSString *)getUmengCode:(NSString *)code;

@end
