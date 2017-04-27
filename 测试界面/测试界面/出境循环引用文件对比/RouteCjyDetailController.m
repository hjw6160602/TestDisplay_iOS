//
//  RouteCjyDetailController.m
//  Lvmm
//
//  Created by SaiDiCaprio on 17/3/14.
//  Copyright © 2016年 Lvmama. All rights reserved.
//
#import <Masonry/Masonry.h>

#import <LvmmBaseClass/DBHelper.h>
#import <LvmmBaseClass/ServicePhoneCallManager.h>

#import <LvmmCategory/UIView+LVHudLoad.h>
#import <LvmmCategory/UITableView+LVUtil.h>
#import <LvmmCategory/UIWebView+LoadRequest.h>

#import <LvmmCommonView/DashLineView.h>
#import <LvmmCommonView/StarPointView.h>
#import <LvmmCommonView/LVDialogMessage.h>
#import <LvmmCommonView/PlainCellBgView.h>
#import <LvmmCommonView/LVSegmentControl.h>
#import <LvmmCommonView/GroupedCellBgView.h>
#import <LvmmCommonView/ScrollImageViewer.h>
#import <LvmmCommonView/PlainSectionHeaderView.h>

#import <LvmmConfig/LvmmConstant.h>
#import <LvmmConfig/LvmmConfigDefine.h>

#import <LvmmModel/CmtScore.h>
#import <LvmmModel/ImageBase.h>
#import <LvmmModel/TimePrice.h>
#import <LvmmModel/CmtComment.h>
#import <LvmmModel/CmtActivity.h>
#import <LvmmModel/TrainFlight.h>
#import <LvmmModel/ProdLineRoute.h>
#import <LvmmModel/ProdLineRouteVo.h>
#import <LvmmModel/RoutePositionVo.h>
#import <LvmmModel/ProdProductPropBase.h>
#import <LvmmModel/ClientSimpleDistrictVo.h>

#import <LvmmStatistics/WapperUM.h>
#import <LvmmStatistics/LvKSharedData.h>
#import <LvmmStatistics/ReferLoscUtil.h>
#import <LvmmStatistics/LvmmTagSupport.h>
#import <LvmmStatistics/RhinoStatistics.h>

#import <LvmmMediator/LVMediatorAll.h>
#import <LvmmMediator/LVAdapterManager.h>

#import <LVMMNetwork/LVMMRequestWeiba.h>
#import <LvmmLocation/LvmmLocationManager.h>
#import <LvmmRouteCommon/RouteShipActivityView.h>

#import "CjyDetailActivityView.h"
#import "RouteCjyLineDetailView.h"

#import "CjyNameCell.h"
#import "CjyNoticeCell.h"
#import "CjyNoticeTipsCell.h"
#import "CjyDetailImageCell.h"
#import "CjyHappyLvXingCell.h"
#import "CjyStampProductCell.h"
#import "CjyDetailTrafficCell.h"
#import "CjyReferenceTrafficCell.h"
#import "CjyProdFeatherShowMoreCell.h"
#import "CjyRecommentPageScrollView.h"
#import "CjyProdLineRouteVoChooseCell.h"
#import "RouteCjyDetailDateChooseCell.h"
#import "CjyGeneralDetailGroupCell.h"
#import "JourneyDepartureDateCell.h"

#import "JourneyDepartureDateVM.h"
#import "RouteCjyDetailBaseViewModel.h"
#import "RouteCjyDetailNoticeViewModel.h"
#import "RouteCjyDetailTrafficViewModel.h"
#import "RouteCjyDetailGeneralViewModel.h"
#import "RouteCjyDetailActivityViewModel.h"
#import "RouteCjyDetailDateChooseViewModel.h"
#import "RouteCjyDetailImageTitleViewModel.h"
#import "RouteCjyDetailCommentDataViewModel.h"
#import "RouteCjyDetailHappyLvXingViewModel.h"
#import "RouteCjyDetailTrafficPlaceViewModel.h"
#import "RouteCjyDetailProductFeatherShowMoreVM.h"

#import "LvmmCjyCommonFunction.h"
#import "LVUserDefaultManager+CJY.h"

#import "RouteCjyDetailController.h"
#import "RouteCjySelectDepartureViewController.h"

#define BOTTOM_TAG 100
#define HEAD_HEIGHT 8
#define FOOT_HEIGHT 8
#define CJY_CMBuNameToPinYinCode(categoryId,name) [NSString stringWithFormat:@"%@_%@",categoryId,[LvmmCjyCommonFunction parseBuNameToPinyin:name]]

UIKIT_EXTERN NSString *const kRouteCjyDetailProductFeatureMoreSelectId; //点击产品特色的查看更多
NSString *const kRouteCjyDetailProductFeatureMoreSelectId = @"kRouteCjyDetailProductFeatureMoreSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailLineMoreSelectId; //点击查看线路的图文详情
NSString *const kRouteCjyDetailLineMoreSelectId = @"kRouteCjyDetailLineMoreSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailTrafficMoreSelectId; //点击查看更多交通信息
NSString *const kRouteCjyDetailTrafficMoreSelectId = @"kRouteCjyDetailTrafficMoreSelectId";

//点评相关
UIKIT_EXTERN NSString *const kRouteCjyDetailCommentReturnMoneySelectId; //点击查看点评相关返现信息
NSString *const kRouteCjyDetailCommentReturnMoneySelectId = @"kRouteCjyDetailCommentReturnMoneySelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailCommentMoreSelectId; //点击查看更多点评信息
NSString *const kRouteCjyDetailCommentMoreSelectId = @"kRouteCjyDetailCommentMoreSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailPMRecommendSelectId; //点击产品经理推荐
NSString *const kRouteCjyDetailPMRecommendSelectId = @"kRouteCjyDetailPMRecommendSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailAnnouncementSelectId; //点击公告
NSString *const kRouteCjyDetailAnnouncementSelectId = @"kRouteCjyDetailAnnouncementSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailStampProductSelectId; //预售产品
NSString *const kRouteCjyDetailStampProductSelectId = @"kRouteCjyDetailStampProductSelectId";

UIKIT_EXTERN NSString *const kRouteCjyDetailDepartureSelectId; //点击更多出发地
NSString *const kRouteCjyDetailDepartureSelectId = @"kRouteGnyDetailDepartureSelectId";

typedef NS_ENUM(NSUInteger, kRouteCjyTapViewType) {
    kRouteCjyTapViewTypeRoute = 0,  //行程介绍
    kRouteCjyTapViewTypeDetail,     //产品特色
    kRouteCjyTapViewCostDescription,//费用说明
    kRouteCjyTapViewReserveNotice   //预订须知
};

/*
 点击详情页面 隐藏弹出的view:在tapCellAction tapHeaderAction tapViewClicked 轮播图 切换多行程 猜你喜欢 收藏 客服 立即预订 滑动tableView 10个地方处理
 if ([_delegate respondsToSelector:@selector(hideCjyNavigationView)]) {
 [_delegate hideCjyNavigationView];
 }
 */
@interface RouteCjyDetailController () <UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate, BaseTapViewDelegate, CjyGeneralDetailGroupCellDelegate, RouteCjyDetailDateChooseViewModelDelegate, LVMMNetworkManagerDelegate, CjyRecommentPageScrollViewDelegate, CjyProdLineRouteVoChooseCellDelegate>{
    
    float screenWidth;
    float bottomHeight;
    BOOL firstCommentRequest;
    BOOL firstProductLineRequest;
    
    // 7.3 多行程新加字段
    NSInteger prodLineSelectIndex; // 当前选中行程的下标
    NSMutableArray *timePriceArray; //时间价格表
    NSMutableArray *routeProductArray; // 存储线路对象，用于显示猜你喜欢
    NSMutableDictionary *prodLineRouteDic; // 存储行程结构化对象列表数据 行程信息
    NSMutableDictionary *_isLineRouteRequesting;   //多行程中行程是否在请求网络 key:ProdLineRoute.lineRouteId value:BOOL
    
    UIView *bottomBar; //订单总额bar
    UIButton *backTopButton; // 回到顶部按钮
    UIButton *picTextButton; // 图文详情按钮
    
    CjyStampProductCell *stampProductCell; //预售产品cell
    CjyProdLineRouteVoChooseCell *prodLineRouteVoChooseCell; // 选择多行程cell
    CjyRecommentPageScrollView *recommentPageScrollView; // 猜你喜欢
    
    ProdLineRouteVo *currentProdLineRouteVo; // 当前选中的行程
    CmtActivity *cmtActivity; // 点评通知对象
    ProdLineRoute *currentProdLineRoute; // 当前选中的行程结构化对象
    
    CjyNameCell *routeNameCell;
    CjyNoticeCell *routeNoticeCell;
    CjyNoticeTipsCell *announcementCell;
    CjyNoticeTipsCell *recommendReasonCell;
    CjyDetailImageCell *routeDetailImageCell;
    CjyDetailTrafficCell *routeDetailTrafficCell; // 自由行 景加酒 不行程结构化 使用之前的行程cell
    
    IBOutlet UIView *loadFailView;
    __weak IBOutlet UIButton *reloadBtn;
}

@property (nonatomic, assign) BOOL isFstRhinoStat;//RhinoStatistics统计

@property (nonatomic, strong) NSArray *tapViewTypeArray; //tabbar有几个分类
@property (nonatomic, strong) NSArray<NSArray<RouteCjyDetailBaseViewModel *> *> *cellArray;
@property (nonatomic, assign) NSInteger tapViewSectionIndex;//tapView所在的section
@property (nonatomic, strong) NSIndexPath *scrollingIndexPath; // 正在滚动到该indexPath,解决滚动中webView的高度变化后滚动位置不对
@property (nonatomic, strong) NSArray<NSIndexPath *> *detailTabbarFirstIndexArray;//tabbar的每个分类的第一次cell的位置

@property (nonatomic, strong) LVMMNetwork *lvmmNetwork;
@property (nonatomic, strong) LVSegmentControl *tapView;

/** 792 新增，是否点击了 产品特色 的 查看更多 */
@property (nonatomic, strong) RouteCjyDetailProductFeatherShowMoreVM *prodFeatherShowMoreVM;
@property (nonatomic, strong) RouteCjyDetailBaseViewModel *webViewDetailCellModel;
@property (nonatomic, strong) JourneyDepartureDateVM *journeyDaysVM;

@property (strong, nonatomic) IBOutlet EGOMJTableView *cjyTableview;
- (IBAction)refreshDetail:(id)sender;

@end

@implementation RouteCjyDetailController

#pragma mark - LifeCircle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    if ([LVMMNetworkStatusManager sharedNetworkStatusManager].networkType == LVNetworkType_None) {
        [super showNetworkNoneView];
        return;
    }
    
    [self initParams];
    [self initUI];
    [self.detailWebview.scrollView addObserver:self
                                    forKeyPath:@"contentSize"
                                       options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                       context:nil];
}

- (void)dealloc {
    SAFERELEASE_TABLEVIEW(_cjyTableview);
    [self.detailWebview.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [WapperUM beginLogPageView:CMControllerName];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.selectedDateString = nil;
    [self rhinoStatIsFst:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [WapperUM endLogPageView:CMControllerName];
}

#pragma mark - Init 初始化
- (void)initParams {
    screenWidth = [UIScreen lvScreenWidth];
    timePriceArray = [[NSMutableArray alloc] init];
    self.allPropDic = [[NSMutableDictionary alloc] init];
    firstCommentRequest = YES;
    firstProductLineRequest = NO;
    _isLineRouteRequesting = [NSMutableDictionary dictionary];
    self.selectedDateString = @"";
    routeProductArray = [[NSMutableArray alloc] init];
    prodLineSelectIndex = 0;
    currentProdLineRouteVo = [[ProdLineRouteVo alloc] init];
    currentProdLineRoute = [[ProdLineRoute alloc] init];
    prodLineRouteDic = [[NSMutableDictionary alloc] init];
    self.isFstRhinoStat = YES;
}

- (void)initUI {
    [self registerTableViewCell];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cjyTableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.cjyTableview.separatorColor = [UIColor clearColor];
    self.cjyTableview.delegate = self;
    self.cjyTableview.dataSource = self;
    [self.view bringSubviewToFront:self.cjyTableview];
    
    self.detailWebview = [[UIWebView alloc] init];
    self.detailWebview.delegate = self;
    self.detailWebview.userInteractionEnabled = false;
    self.detailWebview.scrollView.scrollsToTop = false;
    self.detailWebview.backgroundColor = [UIColor lvColorWithHexadecimal:kColorMainBackground];
    
    // 点击隐藏弹出的view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPresentView:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    reloadBtn.layer.cornerRadius = 2.0f;
    // 导航栏背景图片
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen lvScreenWidth], 64)];
    imageview.transform = CGAffineTransformMakeRotation(M_PI);
    imageview.image = [UIImage imageNamed:@"placeDetailBg.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    [self.view addSubview:imageview];
    // 回到顶部和图文详情悬浮按钮
    backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backTopButton.frame = CGRectMake([UIScreen lvScreenWidth] - 60, [UIScreen lvScreenHeight] - 115, 45, 45);
    [backTopButton setImage:[UIImage imageNamed:@"routeBackTop.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [backTopButton addTarget:self action:@selector(topAction) forControlEvents:UIControlEventTouchUpInside];
    backTopButton.hidden = YES;
    [self.view addSubview:backTopButton];
    
    picTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    picTextButton.frame = CGRectMake([UIScreen lvScreenWidth] - 60, [UIScreen lvScreenHeight] - 172, 45, 45);
    [picTextButton setImage:[UIImage imageNamed:@"routePicTextDetail" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [picTextButton addTarget:self action:@selector(picTextAction) forControlEvents:UIControlEventTouchUpInside];
    picTextButton.hidden = YES;
    if (self.routeProduct.subCategoryId != WINE_SPLIT_CATEGORY_ID) {
        [self.view addSubview:picTextButton];
    }
}

- (void)rhinoStatIsFst:(BOOL)flag {
    if (!flag) {
        self.isFstRhinoStat = flag;
    }
    
    if (self.isFstRhinoStat) {
        return;
    }
    
    NSString *pi = [NSString stringWithFormat:@"%zd",self.routeProduct.productId];
    NSString *ci = [NSString stringWithFormat:@"%zd",self.routeProduct.bizCategoryId];
    NSString *cn = self.routeProduct.categoryName;
    [RhinoStatistics rsDetailPageWithPi:pi ci:ci cn:cn cp:@""];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        // Tableview 滚动的时候webView大小不变，等结束滚动后刷新
        if (self.cjyTableview.delegate && !(self.cjyTableview.dragging || self.cjyTableview.decelerating)) {
            _webViewDetailCellModel.cellHeight = MAX(188, self.detailWebview.scrollView.contentSize.height);
            [self.cjyTableview reloadData];
            if (self.scrollingIndexPath) {
                [self.cjyTableview scrollToRowAtIndexPath:self.scrollingIndexPath atScrollPosition:UITableViewScrollPositionTop animated:false];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

//hidder present view
- (void)hiddenPresentView:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
}

- (void)registerTableViewCell {
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailImageNameCell" bundle:[NSBundle bundleForClass:RouteCjyDetailImageNameCell.class]] forCellReuseIdentifier:@"RouteCjyDetailImageNameCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailHappyLvXingCell" bundle:[NSBundle bundleForClass:RouteCjyDetailHappyLvXingCell.class]] forCellReuseIdentifier:@"RouteCjyDetailHappyLvXingCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailPreferentialActivityCell" bundle:[NSBundle bundleForClass:RouteCjyDetailPreferentialActivityCell.class]] forCellReuseIdentifier:@"RouteCjyDetailPreferentialActivityCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailCommentCountCell" bundle:[NSBundle bundleForClass:RouteCjyDetailCommentCountCell.class]] forCellReuseIdentifier:@"RouteCjyDetailCommentCountCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailCommentRateCell" bundle:[NSBundle bundleForClass:RouteCjyDetailCommentRateCell.class]] forCellReuseIdentifier:@"RouteCjyDetailCommentRateCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailDateChooseCell" bundle:[NSBundle bundleForClass:RouteCjyDetailDateChooseCell.class]] forCellReuseIdentifier:@"RouteCjyDetailDateChooseCell"];
    [self.cjyTableview registerNib:[UINib nibWithNibName:@"RouteCjyDetailTrafficPlaceCell" bundle:[NSBundle bundleForClass:RouteCjyDetailTrafficPlaceCell.class]] forCellReuseIdentifier:@"RouteCjyDetailTrafficPlaceCell"];
}

#pragma mark - Lazy Getter 懒加载
//介绍频道切换的SegmentControl在这里懒加载
- (LVSegmentControl *)tapView {
    if (_tapView==nil) {
        NSArray *array = [NSArray arrayWithObjects:@"产品特色", @"行程介绍", @"费用说明", @"预订须知", nil];
        _tapView = [[LVSegmentControl alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 44) withTitleArray:array delegate:self scrollView:[UIScrollView new]];
        
        UIView *topSeperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 0.5)];
        topSeperatorLine.backgroundColor = [UIColor lvColorWithHexadecimal:kColorLineSplitCell];
        [_tapView addSubview:topSeperatorLine];
        
        CGFloat height = self.tapView.frame.size.height - 0.5;
        UIView *btmSeperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, height, screenWidth, 0.5)];
        btmSeperatorLine.backgroundColor = [UIColor lvColorWithHexadecimal:kColorLineSplitCell];
        [_tapView addSubview:btmSeperatorLine];
    }
    return _tapView;
}

/** 792 新增，是否点击了 产品特色 的 查看更多 */
- (RouteCjyDetailProductFeatherShowMoreVM *)prodFeatherShowMoreVM{
    if (!_prodFeatherShowMoreVM) {
        static NSString *reuseID = @"journeyMoreCellIdentifier";
        CjyProdFeatherShowMoreCell *moreCell = [[CjyProdFeatherShowMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _prodFeatherShowMoreVM = [[RouteCjyDetailProductFeatherShowMoreVM alloc] initWithCell:moreCell cellHeight:44];
    }
    return _prodFeatherShowMoreVM;
}

/** 产品特色详情的WebView */
- (RouteCjyDetailBaseViewModel *)webViewDetailCellModel{
    if (!_webViewDetailCellModel) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"WebViewDetailCell"];
        [self.detailWebview removeFromSuperview];
        self.detailWebview.scrollView.contentOffset = CGPointZero;
        self.detailWebview.backgroundColor = [UIColor clearColor];
        [cell addSubview:self.detailWebview];
        [self.detailWebview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell);
            make.bottom.equalTo(cell);
            make.left.equalTo(cell);
            make.right.equalTo(cell);
        }];
        // webView上加载状态
        [self.webLoadIndicatorView removeFromSuperview];
        [cell addSubview:self.webLoadIndicatorView];
        [self.webLoadIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_top).offset(94);
            make.centerX.equalTo(cell);
        }];
        // 加载失败
        [loadFailView removeFromSuperview];
        [cell addSubview:loadFailView];
        [loadFailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell);
            make.bottom.equalTo(cell);
            make.left.equalTo(cell);
            make.right.equalTo(cell);
        }];
        UIView *bottomline = [[UIView alloc] init];
        bottomline.backgroundColor = [UIColor lvColorWithHexadecimal:kColorLineSplitCell];
        [cell addSubview:bottomline];
        [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell);
            make.right.equalTo(cell);
            make.bottom.equalTo(cell);
            make.height.mas_equalTo(0.5);
        }];
        _webViewDetailCellModel = [[RouteCjyDetailBaseViewModel alloc] initWithCell:cell cellHeight:MAX(188, self.detailWebview.scrollView.contentSize.height)];
        
    }
    return _webViewDetailCellModel;
}
/** 792 新增，最近2个月团期ViewModel */
- (JourneyDepartureDateVM *)journeyDaysVM
{
    if (!_journeyDaysVM) {
        if (self.routeProduct.prodLineRouteVoList.count > 1){
            CGFloat CellHeight = 100;
            JourneyDepartureDateCell *journeyDaysCell = [[JourneyDepartureDateCell alloc]initWithFrame:CGRectMake(0, 0, screenWidth, CellHeight)];
            _journeyDaysVM = [[JourneyDepartureDateVM alloc] initWithCell:journeyDaysCell                                               cellHeight:CellHeight];
            
        }
    }
    return _journeyDaysVM;
}

#pragma mark - Updates更新
// 更新tables的位置
/*
 有行程：@[@"特色", @"行程", @"须知", @"点评"]
 无行程：@[@"特色", @"须知", @"点评"]
 */
- (void)updateTablesHasTrip:(BOOL)hasTrip {
    NSArray *titleArray = [[NSArray alloc] init];
    if (hasTrip) {
        titleArray = @[@"产品特色", @"行程介绍", @"费用说明", @"预订须知"];
        self.tapViewTypeArray = @[@(kRouteCjyTapViewTypeDetail), @(kRouteCjyTapViewTypeRoute), @(kRouteCjyTapViewCostDescription),@(kRouteCjyTapViewReserveNotice)];
    } else {
        if (self.routeProduct.hasTrafficGroups) {
            titleArray = @[@"产品特色", @"行程介绍", @"费用说明", @"预订须知"];
            self.tapViewTypeArray = @[@(kRouteCjyTapViewTypeDetail), @(kRouteCjyTapViewTypeRoute), @(kRouteCjyTapViewCostDescription),@(kRouteCjyTapViewReserveNotice)];
        } else {
            titleArray = @[@"产品特色", @"费用说明", @"预订须知"];
            self.tapViewTypeArray = @[@(kRouteCjyTapViewTypeDetail), @(kRouteCjyTapViewCostDescription),@(kRouteCjyTapViewReserveNotice)];
        }
    }
    [self refreshDetailTabWithTitles:titleArray];
}

/*! 刷新tableView */
- (void)reloadTableviewData {
    [self updateCellsArray];
    [self.cjyTableview reloadData];
}

- (void)updateCellsArray {
    NSMutableArray<NSArray *> *array = [NSMutableArray array];
    //section0: 图片和详细
    NSMutableArray *sections0 = [NSMutableArray array];
    [sections0 addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:routeDetailImageCell cellHeight:fitHeightWithSpaceX(0, 170) - 64]];
    
    // 出境游在图片和详细之间的开心驴行
    if ([RouteCjyDetailHappyLvXingViewModel showCellWithData:self.routeProduct]) {
        [sections0 addObject:[[RouteCjyDetailHappyLvXingViewModel alloc] initWithData:self.routeProduct]];
    }
    
    // 产品线路名称
    routeNameCell.backgroundView = [PlainCellBgView cellBgWithSelected:NO needFirstCellTopLine:YES];
    routeNameCell.backgroundView.frame = routeNameCell.bounds;
    [sections0 addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:routeNameCell cellHeight:floorf(CGRectGetHeight(routeNameCell.frame))]];
    [array addObject:sections0];
    
    //sectionPreferential: 优惠活动
    NSMutableArray *sectionPreferential = [NSMutableArray array];
    if ([RouteCjyDetailActivityViewModel showCellWithData:self.routeProduct]) {
        [sectionPreferential addObject:[[RouteCjyDetailActivityViewModel alloc] initWithData:self.routeProduct]];
    }
    [sectionPreferential addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    [array addObject:sectionPreferential];
    
    //上海出发
    {
        NSMutableArray *sectionsFromDest = [NSMutableArray array];
        BOOL arrow = NO;
        NSString *detailText = @"";
        if (self.routeProduct.multipleDeparture && self.routeProduct.multipleDeparture.count > 0) {
            arrow = YES;
            detailText = [NSString stringWithFormat:@"%@个可选城市", @(self.routeProduct.multipleDeparture.count)];
        }
        NSString *city = @"全国";
        if (self.routeProduct.fromDest.length > 0) {
            city = self.routeProduct.fromDest;
        }
        RouteCjyDetailImageTitleViewModel *model = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:nil title:[NSString stringWithFormat:@"出发城市：%@",city] detailText:detailText arrow:arrow];
        model.selectId = kRouteCjyDetailDepartureSelectId;
        [sectionsFromDest addObject:model];
        
        [sectionsFromDest addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
        [array addObject:sectionsFromDest];
    }
    
    //sectionsDate: 出发日期选择
    NSMutableArray *sectionsDate = [NSMutableArray array];
    NSMutableArray *prodGroupDateVoList = [NSMutableArray array];
    for (ProdGroupDateVo *prodGroupDateVo in self.routeProduct.prodGroupDateVoList) {
        [prodGroupDateVoList addObject:prodGroupDateVo];
    }
    
    // 选择日期
    if ([RouteCjyDetailDateChooseViewModel showCellWithData:prodGroupDateVoList]) {
        // 出发日期CELL
        RouteCjyDetailImageTitleViewModel *model = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"routeSchedule" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"出发日期" detailText:@"" arrow:NO];
        [sectionsDate addObject:model];
        // 日期价格
        [sectionsDate addObject:[[RouteCjyDetailDateChooseViewModel alloc] initWithData:prodGroupDateVoList]];
    } else {
        UITableViewCell *noDateCell = [self getSectionNoDateCell:@"暂无该行程的团期，请查看其它行程" withSection:5];
        noDateCell.backgroundView = [PlainCellBgView cellBgWithSelected:NO needFirstCellTopLine:NO];
        [sectionsDate addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:noDateCell cellHeight:30]];
    }
    
    
    [sectionsDate addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    [array addObject:sectionsDate];
    
    //sectionTips: 公告
    NSMutableArray *sectionTips = [NSMutableArray array];
    if (announcementCell) {
        announcementCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:2 withIndex:1 isPlain:true needArrow:false isSelected:false];
        [sectionTips addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"announcement" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"公告" detailText:@"" arrow:NO]];
        RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:announcementCell cellHeight:floorf(CGRectGetHeight(announcementCell.bounds))];
        model.selectId = kRouteCjyDetailAnnouncementSelectId;
        [sectionTips addObject:model];
        
        [sectionTips addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    }
    [array addObject:sectionTips];
    
    
    //sectionCmt：游客点评，791定制游隐藏点评
    if (![self.routeProduct.categoryCode isEqualToString:@"CATEGORY_ROUTE_CUSTOMIZED"]) {
        NSMutableArray *sectionCmt = [NSMutableArray array];
        if ([RouteCjyDetailCommentDataViewModel showCommentCountData:self.routeProduct]) {
            [sectionCmt addObject:[[RouteCjyDetailCommentDataViewModel alloc] initWithCommentCountData:self.routeProduct]];
            if ([RouteCjyDetailCommentDataViewModel showCommentRateData:self.routeProduct]) {
                [sectionCmt addObject:[[RouteCjyDetailCommentDataViewModel alloc] initWithCommentRateData:self.routeProduct]];
            }
            [sectionCmt addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
        }
        [array addObject:sectionCmt];
    }
    
    //sectionPresell: 预售产品
    NSMutableArray *sectionPresell = [NSMutableArray array];
    if (self.routeProduct.hasStamp) {
        RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:stampProductCell cellHeight:44];
        model.selectId = kRouteCjyDetailStampProductSelectId;
        [sectionPresell addObject:model];
        [sectionPresell addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    }
    [array addObject:sectionPresell];
    
    //sectionRoute: 多行程线路选择
    BOOL routechoose = self.routeProduct.prodLineRouteVoList.count > 1;
    if (routechoose) {//线路行程选择
        NSMutableArray *sectionRoute = [NSMutableArray array];
        prodLineRouteVoChooseCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:true needArrow:false isSelected:false];
        [sectionRoute addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:prodLineRouteVoChooseCell cellHeight:44]];
        [array addObject:sectionRoute];
    }
    
    //sectionSeg: 产品特色、行程介绍、费用说明、预订须知。必须放在一个section里面（后面判断行程会进行使用）
    NSMutableArray *sectionSeg = [NSMutableArray array];
    self.tapViewSectionIndex = array.count;
    //tapView所在的section
    [sectionSeg addObjectsFromArray:[self getDetailTabbarCellArraySection:self.tapViewSectionIndex]];
    [array addObject:sectionSeg];
    
    //sections7: 签注/签证
    NSMutableArray *sections7 = [NSMutableArray array];
    if (currentProdLineRouteVo.visa) {
        RouteCjyDetailNoticeViewModel *model = [[RouteCjyDetailNoticeViewModel alloc] initTitle:@"签注/签证" iconImage:[UIImage imageNamed:@"routeDetailIcon6" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        model.didSelectUrl = currentProdLineRouteVo.visaUrl;
        [sections7 addObject:model];
    }
    
    // 退改说明 PROP_CHANGE_AND_CANCELLATION_INSTRUCTIONS
    ProdProductPropBase *instructionsProductPropBase = [self getProdProductPropByCode:PROP_CHANGE_AND_CANCELLATION_INSTRUCTIONS];
    if (instructionsProductPropBase.value.length > 0) {
        RouteCjyDetailNoticeViewModel *model = [[RouteCjyDetailNoticeViewModel alloc] initTitle:instructionsProductPropBase.name iconImage:[UIImage imageNamed:@"routeChangeCancel" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        model.didSelectDescriptionInfo = instructionsProductPropBase.value;
        [sections7 addObject:model];
    }
    
    // 出行警示 PROP_WARNING
    ProdProductPropBase *warningProductPropBase = [self getProdProductPropByCode:PROP_WARNING];
    if (warningProductPropBase.value.length > 0) {
        RouteCjyDetailNoticeViewModel *model = [[RouteCjyDetailNoticeViewModel alloc] initTitle:warningProductPropBase.name iconImage:[UIImage imageNamed:@"routeTips" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        model.didSelectDescriptionInfo = warningProductPropBase.value;
        [sections7 addObject:model];
    }
    [sections7 addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    [array addObject:sections7];
    
    
    // 猜你喜欢
    NSMutableArray *sections8 = [NSMutableArray array];
    if (routeProductArray.count > 0) {
        [sections8 addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"guessYouLike" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"猜你喜欢" detailText:@"" arrow:NO]];
        static NSString *favoriteIdentifier = @"favoriteCellIdentifier";
        UITableViewCell *cell = [self.cjyTableview dequeueReusableCellWithIdentifier:favoriteIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:favoriteIdentifier];
        }
        if (recommentPageScrollView) {
            cell.frame = CGRectMake(0, 0, CGRectGetWidth(self.cjyTableview.frame), CGRectGetHeight(recommentPageScrollView.bounds));
            recommentPageScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.cjyTableview.frame), CGRectGetHeight(recommentPageScrollView.bounds));
            [cell.contentView addSubview:recommentPageScrollView];
        }
        // 画下面分割线
        cell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:cell.bounds withDataSourceCount:2 withIndex:1 isPlain:true needArrow:false isSelected:false];
        [sections8 addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:cell cellHeight:floorf(CGRectGetHeight(recommentPageScrollView.bounds))]];
    }
    [array addObject:sections8];
    //底部
    [array addObject:@[[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]]];
    self.cellArray = array;
}


// section 7 行程、产品特色、点评、须知必须放在一个section里面（后面判断行程时方法:updatePicTextButton会用到）
- (NSArray *)getDetailTabbarCellArraySection:(NSInteger)section {
    NSMutableArray *rows = [NSMutableArray array];
    NSMutableArray *firstIndexArray = [NSMutableArray array];
    
    for (NSNumber *number in self.tapViewTypeArray) {
        kRouteCjyTapViewType type = number.integerValue;
        switch (type) {
            case kRouteCjyTapViewTypeDetail://产品特色
                [firstIndexArray addObject:[NSIndexPath indexPathForRow:rows.count inSection:section]];
                [rows addObjectsFromArray:[self getProductDetailCellArray]];
                break;
                
            case kRouteCjyTapViewTypeRoute://行程概况
                [firstIndexArray addObject:[NSIndexPath indexPathForRow:rows.count inSection:section]];
                [rows addObjectsFromArray:[self getRouteCellArray]];
                break;
            case kRouteCjyTapViewCostDescription://费用说明
                [firstIndexArray addObject:[NSIndexPath indexPathForRow:rows.count inSection:section]];
                [rows addObjectsFromArray:[self getCostDescCellArray]];
                break;
            case kRouteCjyTapViewReserveNotice://预订须知
                [firstIndexArray addObject:[NSIndexPath indexPathForRow:rows.count inSection:section]];
                [rows addObjectsFromArray:[self getReserveNoticeCellArray]];
                break;
        }
        [rows addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    }
    self.detailTabbarFirstIndexArray = firstIndexArray;
    return rows;
}


#pragma mark - 4大锚点模块的数据源方法
- (NSArray *)getProductDetailCellArray {
    NSMutableArray *cells = [NSMutableArray array];
    //7.9.2新增产品特色下，最近2个月团期
    if (self.journeyDaysVM && [self.routeProduct.categoryCode isEqualToString:@"CATEGORY_ROUTE_GROUP"])
    {
        [cells addObject:self.journeyDaysVM];
    }
    
    [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    
    [cells addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"productFeatures" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"产品特色" detailText:@"" arrow:NO]];
    // 产品经理推荐
    if (recommendReasonCell) {
        CGFloat addHeight = 30;
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PMRecommendCellIdentifier"];
        cell.frame = CGRectMake(0, 0, CGRectGetWidth(recommendReasonCell.bounds), CGRectGetHeight(recommendReasonCell.bounds) + addHeight);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 250, 15)];
        label.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
        label.textColor = [UIColor lvColorWithHexadecimal:kColorTextBlack];
        label.text = @"产品经理推荐";
        [cell addSubview:label];
        [recommendReasonCell removeFromSuperview];
        [cell addSubview:recommendReasonCell];
        
        recommendReasonCell.frame = CGRectMake(recommendReasonCell.frame.origin.x, addHeight,recommendReasonCell.frame.size.width, recommendReasonCell.frame.size.height);
        recommendReasonCell.userInteractionEnabled = false;
        cell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:3 withIndex:1 isPlain:true needArrow:false isSelected:false];
        RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:cell cellHeight:floorf(CGRectGetHeight(cell.bounds))];
        model.selectId = kRouteCjyDetailPMRecommendSelectId;
        [cells addObject:model];
    }
    RouteCjyDetailProductFeatherShowMoreVM *model = self.prodFeatherShowMoreVM;
    CjyProdFeatherShowMoreCell *cell = (CjyProdFeatherShowMoreCell *)model.tabelViewcell;
    if (cell.hasShown) {
        [cells addObject:self.webViewDetailCellModel];
    }
    [cells addObject:model];
    
    return cells;
}

- (NSArray *)getRouteCellArray {
    NSMutableArray *cells = [NSMutableArray array];
    
    // 大交通信息的内容
    if (self.routeProduct.hasTrafficGroups) {
        TrainFlightType *trainFlightType = [self.routeProduct.trafficGroups objectAtIndex:0];
        NSUInteger count = trainFlightType.toTrafficArray.count + trainFlightType.backTrafficArray.count;
        
        // row.0 参考交通
        RouteCjyDetailImageTitleViewModel *model = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"planeTraffic" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"参考交通" detailText:@"" arrow:NO];
        model.titleDetail = @"起降时间均为当地时间";
        [cells addObject:model];
        
        // row.1~row.n 行程下的大交通信息，供应商打包，国内，出境
        for (int index = 1; index < count + 1; index ++) {
            TrainFlightVo *trainFlightVo;
            if (index >=1 && index < [trainFlightType.toTrafficArray count] + 1) {
                trainFlightVo = [trainFlightType.toTrafficArray objectAtIndex:index - 1];
            } else {
                trainFlightVo = [trainFlightType.backTrafficArray objectAtIndex:(index - 1 - [trainFlightType.toTrafficArray count])];
            }
            RouteCjyDetailTrafficViewModel *model = [[RouteCjyDetailTrafficViewModel alloc] initWithData:trainFlightVo];
            //画底部分割线(只有一条交通信息时不显示"点击查看更多信息"，需添加分割线)
            model.bottomLine = index == count && [self.routeProduct.trafficGroups count] == 1;
            [cells addObject:model];
        }
        
        // row.n+1 只有一条交通信息时不显示"点击查看更多信息"
        if ([self.routeProduct.trafficGroups count] > 1) {
            RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:[self getMoreTrafficCell:self.cjyTableview indexPath:[NSIndexPath indexPathForRow:3 inSection:7 ]] cellHeight:44];
            model.selectId = kRouteCjyDetailTrafficMoreSelectId;
            [cells addObject:model];
        }
        
        // section view用透明cell代替
        [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    }
    //
    //行程概况
    [cells addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"lineProfile" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"行程概况" detailText:@"" arrow:NO]];
    // 行程信息
    if (self.routeProduct.subCategoryId == WINE_SPLIT_CATEGORY_ID) {
        if (!routeDetailTrafficCell) {
            routeDetailTrafficCell = [[CjyDetailTrafficCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"routeDetailTrafficCell"];
            if ([self getProdProductPropByCode:PROP_TRAFFIC_REACH].value.length > 0) {
                routeDetailTrafficCell.trafficReach = [self getProdProductPropByCode:PROP_TRAFFIC_REACH].value;
            }
        }
        routeDetailTrafficCell.prodLineRouteDetailVoList = [currentProdLineRouteVo.prodLineRouteDetailVoList copy];
        [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:routeDetailTrafficCell cellHeight:[routeDetailTrafficCell getTableViewHeight]]];
    }else {
        NSUInteger prodLineNum = currentProdLineRoute.prodLineRouteDetailVoList.count;
        // 有行程时同时显示:免责说明和查看图文详情（后2个cell）
        if (prodLineNum > 0) {// 第1天、第2天...
            for (int index = 0; index < prodLineNum; index ++) {
                RouteCjyDetailGeneralViewModel *model = [[RouteCjyDetailGeneralViewModel alloc] initWithData:currentProdLineRoute.prodLineRouteDetailVoList[index]];
                model.dayIndex = index + 1;
                model.dayCount = prodLineNum;
                [cells addObject:model];
            }
            // 免责说明
            if (currentProdLineRoute.lineDetailtext.length) {
                static NSString *tipCellIdentifier = @"tipCellIdentifier";
                UITableViewCell *tipCell = [self.cjyTableview dequeueReusableCellWithIdentifier:tipCellIdentifier];
                CGFloat titleHeight = [LvmmUtil lvTextHeight:screenWidth - 20 text:currentProdLineRoute.lineDetailtext fontSize:kFontForth14 isBold:NO needOriginSize:NO];
                if (!tipCell) {
                    tipCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tipCellIdentifier];
                    UILabel *tipLabel = [[UILabel alloc] init];
                    tipLabel.frame = CGRectMake(10, 10, [UIScreen lvScreenWidth] - 20, titleHeight);
                    tipLabel.backgroundColor = [UIColor clearColor];
                    tipLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextRed];
                    tipLabel.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
                    tipLabel.numberOfLines = 0;
                    tipLabel.text = currentProdLineRoute.lineDetailtext;
                    [tipCell.contentView addSubview:tipLabel];
                    tipCell.bounds = CGRectMake(0, 0, [UIScreen lvScreenWidth], titleHeight + 15);
                }
                [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:tipCell cellHeight:titleHeight + 20]];
            }
            // 查看图文详情
            if (currentProdLineRoute.lineDetailUrl.length > 0) {
                static NSString *moreCellIdentifier = @"moreCellIdentifier";
                UITableViewCell *moreCell = [self.cjyTableview dequeueReusableCellWithIdentifier:moreCellIdentifier];
                if (!moreCell) {
                    moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentifier];
                    UILabel *moreLabel = [UILabel lvLabelWithFrame:CGRectMake(10, 0, [UIScreen lvScreenWidth] - 30, 44)
                                                         textColor:[UIColor lvColorWithHexadecimal:kColorTextDarkGray]
                                                              font:[UIFont lvFontWithHelveticaSize:kFontSecond16]
                                                   backgroundColor:[UIColor clearColor]];
                    moreLabel.text = @"查看更多图文详情";
                    [moreCell.contentView addSubview:moreLabel];
                }
                //画上下两条分割线 右边有箭头
                moreCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:moreCell.bounds withDataSourceCount:1 withIndex:2 isPlain:YES needArrow:YES isSelected:NO];
                RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:moreCell cellHeight:44];
                model.selectId = kRouteCjyDetailLineMoreSelectId;
                [cells addObject:model];
            }
        } else {
            //没有行程的提示
            BOOL isRouteRequesting = [[_isLineRouteRequesting valueForKey:[NSString stringWithFormat:@"%lld", currentProdLineRouteVo.lineRouteId]] boolValue];
            if (isRouteRequesting) {
                [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:[self getLoadingCell] cellHeight:100]];
            } else {
                UITableViewCell *cell = [self createNoticeCellWithTableView:self.cjyTableview];
                cell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.cjyTableview.bounds), 100) withDataSourceCount:2 withIndex:1 isPlain:YES needArrow:NO isSelected:NO];
                [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:cell cellHeight:100]];
            }
        }
    }
    
    //上下车地点
    ProdTraffic *prodTraffic = self.routeProduct.prodTraffic;
    BOOL showFrontBus = prodTraffic.showFrontBus && prodTraffic.frontBusStops.count > 0;
    BOOL showBackBus = prodTraffic.showBackBus && prodTraffic.backBusStops.count > 0;
    if (showFrontBus || showBackBus) {
        [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:HEAD_HEIGHT]];
        RouteCjyDetailImageTitleViewModel *model = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"getOnSite" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"上车点" detailText:@"" arrow:NO];
        [cells addObject:model];
        if (showFrontBus) {
            [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:[self showFrontBackBusCell:@"去程集合点"] cellHeight:25]];
            [prodTraffic.frontBusStops enumerateObjectsUsingBlock:^(ProdTrafficBusVo * _Nonnull prodTrafficBusVo, NSUInteger idx, BOOL * _Nonnull stop) {
                [cells addObject:[[RouteCjyDetailTrafficPlaceViewModel alloc] initWithData:prodTrafficBusVo index:idx end:showBackBus ? false : (idx == prodTraffic.frontBusStops.count - 1)]];
            }];
        }
        if (showBackBus) {
            [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:[self showFrontBackBusCell:@"返程集合点"] cellHeight:25]];
            [prodTraffic.backBusStops enumerateObjectsUsingBlock:^(ProdTrafficBusVo * _Nonnull prodTrafficBusVo, NSUInteger idx, BOOL * _Nonnull stop) {
                [cells addObject:[[RouteCjyDetailTrafficPlaceViewModel alloc] initWithData:prodTrafficBusVo index:idx end:(idx == prodTraffic.backBusStops.count - 1)]];
            }];
        }
    }
    
    return cells;
}

- (NSArray *)getCostDescCellArray {
    NSMutableArray *cells = [NSMutableArray array];
    [cells addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"costInformation" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"费用说明" detailText:@"" arrow:NO]];
    // 费用包含 不包含
    if (routeNoticeCell) {
        UIView *backgroundView = [PlainCellBgView cellBgWithSelected:NO needFirstCellTopLine:NO];
        backgroundView.frame = routeNoticeCell.bounds;
        routeNoticeCell.backgroundView = backgroundView;
        [cells addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:routeNoticeCell cellHeight:CGRectGetHeight(routeNoticeCell.bounds)]];
    }
    
    // 推荐项目走H5 PROP_RECOMMENDED_ITEMS
    ProdProductPropBase *recommendProductPropBase = [self getProdProductPropByCode:PROP_RECOMMENDED_ITEMS];
    if (recommendProductPropBase.value.length > 0) {
        RouteCjyDetailNoticeViewModel *model = [[RouteCjyDetailNoticeViewModel alloc] initTitle:recommendProductPropBase.name iconImage:[UIImage imageNamed:@"routeDetailIcon14" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        model.didSelectUrl = recommendProductPropBase.url;
        [cells addObject:model];
    }
    
    // 购物说明走H5 PROP_SHOPPING_HELP
    ProdProductPropBase *shoppingProductPropBase = [self getProdProductPropByCode:PROP_SHOPPING_HELP];
    if (shoppingProductPropBase.value.length > 0) {
        RouteCjyDetailNoticeViewModel *model = [[RouteCjyDetailNoticeViewModel alloc] initTitle:shoppingProductPropBase.name iconImage:[UIImage imageNamed:@"routeDetailIcon19" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        model.didSelectUrl = shoppingProductPropBase.url;
        [cells addObject:model];
    }
    
    return cells;
}

- (NSArray *)getReserveNoticeCellArray{
    NSMutableArray *cells = [NSMutableArray array];
    // 预订须知  显示法务描述
    ProdProductPropBase *noticeProductPropBase = [ProdProductPropBase new];
    ProdProductPropBase *importantProductPropBase = [self getProdProductPropByCode:PROP_IMPORTANT]; // 预订须知 PROP_IMPORTANT
    ProdProductPropBase *legalProductPropBase = [self getProdProductPropByCode:PROP_LEGAL_PROVISION]; //法务描述 PROP_LEGAL_PROVISION
    if (importantProductPropBase.value.length > 0) {
        importantProductPropBase.name = importantProductPropBase.name;
    } else {
        noticeProductPropBase.name = @"预订须知";
    }
    if (legalProductPropBase.value.length > 0) {
        noticeProductPropBase.value = legalProductPropBase.value;
    } else {
        noticeProductPropBase.value = importantProductPropBase.value;
    }
    if (noticeProductPropBase.value.length > 0) {
        [cells addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"reverseNotice" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"预订须知" detailText:@"" arrow:NO]];
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ReserveNoticeCellIdentifier"];
        
        cell.frame = CGRectMake(0, 0, screenWidth, 55);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-20, 55)];
        label.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
        label.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
        label.text = noticeProductPropBase.value;
        label.numberOfLines = 0;
        [cell addSubview:label];
        
        cell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:2 withIndex:1 isPlain:true needArrow:false isSelected:false];
        RouteCjyDetailBaseViewModel *model = [[RouteCjyDetailBaseViewModel alloc] initWithCell:cell cellHeight:55];
        [cells addObject:model];
    }
    return cells;
}
#pragma mark -

// 获取加载状态的cell
- (UITableViewCell *)getLoadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@""];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    animationView.backgroundColor = [UIColor clearColor];
    [cell addSubview:animationView];
    [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell);
        make.centerY.equalTo(cell);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    [animationView startAnimationWithOffsetY:20];
    cell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.cjyTableview.bounds), 100) withDataSourceCount:2 withIndex:1 isPlain:YES needArrow:NO isSelected:NO];
    
    return cell;
}

// 去程集合点、返程集合点
- (UITableViewCell *)showFrontBackBusCell:(NSString *)title {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FrontBackBusCell"];
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = [UIColor lvColorWithHexadecimal:kColorTextRed];
    label.font = [UIFont lvFontWithHelveticaSize:kFontSix11];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor lvColorWithHexadecimal:kColorTextRed].CGColor;
    label.tag = 101;
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(10);
        make.top.equalTo(cell.contentView).offset(9);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(63);
    }];
    
    return cell;
}

- (void)setObjectsFromRouteProduct {
    // 请求猜你喜欢接口的数据
    [self requestFavoriteList];
    [self requestCommentData];
    self.routeProduct.productType = self.routeProduct.categoryName;
    self.routeProduct.visitDay = [NSString stringWithFormat:@"%d", self.routeProduct.lineRouteNumOfDays];
    [self requestAdvertiseBehavior];
    [WapperUM event:[self getUmengCode:@"040"]];
    NSString *rangeType = [LvmmCjyCommonFunction CMSplicingForwardSlashWithString:self.routeProduct.cmProductRangeType];
    NSString *packageType = [LvmmCjyCommonFunction CMSplicingForwardSlashWithString:[LvmmCjyCommonFunction CMPackageTypeWithBool:self.routeProduct.packageTypeFlag]];
    [LvmmTagSupport firePageView:[NSString stringWithFormat:@"IP_出境游_产品详情_%@_%@_常规_%lld", [NSString stringWithFormat:@"%@%@%@",rangeType,packageType,self.routeProduct.cmCategoryName], self.routeProduct.cmProductType, self.routeProduct.productId]
                              cg:[NSString stringWithFormat:@"IP_Abroad_ProductDetail_%@", [LvmmCjyCommonFunction parseBizCategoryIdToEnName:self.routeProduct.bizCategoryId andSubCategoryId:self.routeProduct.subCategoryId]]
                              se:@""
                              sr:@""
                      attributes:[NSString stringWithFormat:@"%@-_-%@-_-%@",CMPageAttribute,@"产品页面", self.tailCode.length > 0 ? self.tailCode : @""]
                          cm_mmc:nil];
    [LvmmTagSupport fireProductView:[NSString stringWithFormat:@"IP_出境游_产品详情_%@_%@_常规_%lld", self.routeProduct.cmCategoryName, self.routeProduct.cmProductType, self.routeProduct.productId] pr:[NSString stringWithFormat:@"IP_出境游_产品详情_%@_%@_常规_%lld", self.routeProduct.cmCategoryName, self.routeProduct.cmProductType, self.routeProduct.productId] pm:self.routeProduct.productName cg:@"IP_AbraodDetail" attributes:[NSString stringWithFormat:@"%f-_-%@-_-%@-_-%@",self.routeProduct.sellPrice,self.routeProduct.fromDest,self.routeProduct.toDest,self.routeProduct.buName]];
    
    // 添加公用属性列表
    [self updateAllPropDicWithProductBaseVos:self.routeProduct.clientProdProductPropBaseVos];
    // 初始化多行程cell
    // 切换行程的选择栏
    if (!prodLineRouteVoChooseCell && self.routeProduct.prodLineRouteVoList.count > 1) {
        prodLineRouteVoChooseCell = [[CjyProdLineRouteVoChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"prodLineRouteVoChooseCellIdentifier" withProdLineRouteVoList:[self.routeProduct.prodLineRouteVoList copy]];
        prodLineRouteVoChooseCell.delegate = self;
        prodLineSelectIndex = prodLineRouteVoChooseCell.selectIndex;
    }
    if (self.routeProduct.prodLineRouteVoList.count > 0) {
        [self updateProdLineRouteWithIndex:prodLineSelectIndex];
    } else {
        return;
    }
    [self initbottomBar];
    int num = 0;
    if (currentProdLineRouteVo.visa) {
        num += 1;
    }
    if ([[self getProdProductPropByCode:PROP_RECOMMENDED_ITEMS].value length] > 0) {
        num += 1;
    }
    if ([[self getProdProductPropByCode:PROP_SHOPPING_HELP].value length] > 0) {
        num += 1;
    }
    bottomHeight = num*44 + (num+1)*8;
    if (self.routeProduct.clientImageBaseVos.count > 8) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            [tempArr addObject:self.routeProduct.clientImageBaseVos[i]];
        }
        self.routeProduct.clientImageBaseVos = tempArr;
    }
    routeDetailImageCell = [[CjyDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:@"routeDetailImageCellIdentifier"
                                                  withImageBaseArray:[self.routeProduct.clientImageBaseVos copy]
                                                        withDelegate:self
                                                       isPlaceDetail:NO
                                                     hasCommentScore:nil
                                                     hasCountComment:self.routeProduct.countComment
                                                            hasVideo:self.routeProduct.hasVideo];
    routeNameCell = [[CjyNameCell alloc] initWithStyle:UITableViewCellStyleDefault routeReuseIdentifier:@"routeNameCellIdentifier" withDelegate:self];
    [routeNameCell resetNameCellFrame:self.routeProduct];
    
    if ([[self getProdProductPropByCode:PROP_RECOMMEND].value length] > 0) {
        ProdProductPropBase *prodProductPropBase = [self getProdProductPropByCode:PROP_RECOMMEND];
        recommendReasonCell = [[CjyNoticeTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recommendReasonCellIdentifier" withText:prodProductPropBase.value withLines:4 withUrlString:nil];
    }
    if (_routeProduct.announcement.length > 0) {
        announcementCell = [[CjyNoticeTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"announcementCellIdentifier" withText:_routeProduct.announcement withLines:4 withUrlString:nil];
    }
    //预售产品
    if (self.routeProduct.hasStamp) {
        stampProductCell = [[[NSBundle bundleForClass:CjyStampProductCell.class] loadNibNamed:@"CjyStampProductCell" owner:self options:nil] objectAtIndex:0];
        stampProductCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:stampProductCell.bounds withDataSourceCount:1 withIndex:0 isPlain:YES needArrow:YES isSelected:NO];
    }
    [self saveBrowseCache];
    self.detailWebview.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"blank" ofType:@"html"];;
    NSURL *blankUrl = [NSURL fileURLWithPath:filePath];
    NSURLRequest *blankRequest = [NSURLRequest requestWithURL:blankUrl];
    [self.detailWebview lvmmLoadRequest:blankRequest];
    [self runActivityView];
    // 详情加载失败view,默认隐藏
    loadFailView.hidden = YES;
    if ([LVUserDefaultManager sharedUserDefaultManager].isGrade == NO) {
        [LVUserDefaultManager sharedUserDefaultManager].placeAndRouteNumber = [LVUserDefaultManager sharedUserDefaultManager].placeAndRouteNumber + 1;
    }
    
    [self reloadTableviewData];
}

// 刷新tab
- (void)refreshDetailTabWithTitles:(NSArray *)titleArray {
    if (titleArray.count > 0) {
        self.tapView.titleArray = titleArray;
        self.tapView.selectedIndex = 0;
        [self.tapView.hmControl updateSegmentsRects];
        int xDe = 0;
        double delayInSeconds = .1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.tapView.selectedIndex = xDe;
            [self reloadTableviewData];
        });
    }
}

- (void)initbottomBar {
    bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, [UIScreen lvScreenWidth], 44)];
    bottomBar.backgroundColor = [UIColor lvColorWithHexadecimal:kColorMainWhite];
    bottomBar.hidden = NO;
    [self.view addSubview:bottomBar];
    
    float buttonWidth = IS_IPAD() ? [UIScreen lvScreenWidth]/5 : 75;
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0, 0, buttonWidth, CGRectGetHeight(bottomBar.bounds));
    collectButton.tag = BOTTOM_TAG + 1;
    [collectButton setImage:self.routeProduct.hasIn ? [UIImage imageNamed:@"routeBotCollectSuccess.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] : [UIImage imageNamed:@"routeBotCollect.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorTextLightGray] forState:UIControlStateNormal];
    collectButton.titleLabel.font = [UIFont lvFontWithHelveticaBoldSize:kFontFifth12];
    if (IS_IPAD()) {
        collectButton.imageEdgeInsets = UIEdgeInsetsMake(3, 28 * 2, 21, 28 * 2);
        collectButton.titleEdgeInsets = UIEdgeInsetsMake(20, - 7 * 2, 0, 10 * 2);
    }else{
        collectButton.imageEdgeInsets = UIEdgeInsetsMake(3, 28, 21, 28);
        collectButton.titleEdgeInsets = UIEdgeInsetsMake(20, -9, 0, 10);
    }
    [collectButton addTarget:self action:@selector(favorAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:collectButton];
    // 垂直分割线
    StraightVarLineView *verLine = [[StraightVarLineView alloc] initStraightVarLineWithFrame:CGRectMake(IS_IPAD()?buttonWidth - 10 : 70, 7, 0.5, 30)];
    [bottomBar addSubview:verLine];
    UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    serviceButton.frame = CGRectMake(buttonWidth + 0.5, 0, buttonWidth, CGRectGetHeight(bottomBar.bounds));
    [serviceButton setImage:[UIImage imageNamed:@"routeBotService.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [serviceButton setTitle:@"客服" forState:UIControlStateNormal];
    [serviceButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorTextLightGray] forState:UIControlStateNormal];
    serviceButton.titleLabel.font = [UIFont lvFontWithHelveticaBoldSize:kFontFifth12];
    if (IS_IPAD()) {
        serviceButton.imageEdgeInsets = UIEdgeInsetsMake(3, 28 * 2, 21, 28 * 2);
        serviceButton.titleEdgeInsets = UIEdgeInsetsMake(20, - 7 * 2, 0, 10 * 2);
    }else{
        serviceButton.imageEdgeInsets = UIEdgeInsetsMake(3, 28, 21, 28);
        serviceButton.titleEdgeInsets = UIEdgeInsetsMake(20, -9, 0, 10);
    }
    [serviceButton addTarget:self action:@selector(callCjyLvmamaNumber) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:serviceButton];
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(buttonWidth * 2 + 0.5, 0, CGRectGetWidth(bottomBar.bounds) - buttonWidth * 2 - 0.5, CGRectGetHeight(bottomBar.bounds));
    orderButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [orderButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorTextWhite] forState:UIControlStateNormal];
    orderButton.titleLabel.font = [UIFont lvFontWithHelveticaBoldSize:kFontSecond16];
    // 多出发地 价格为空时显示已售罄,不响应点击事件
    if (self.routeProduct.isManyProductDest && self.routeProduct.sellPrice <= 0.0) {
        [orderButton setTitle:@"已售罄" forState:UIControlStateNormal];
        orderButton.backgroundColor = [UIColor lvColorWithHexadecimal:kColorAssistGray];
        orderButton.enabled = NO;
    } else {
        [orderButton setBackgroundImage:[UIImage lvImageForBtnRedCorner] forState:UIControlStateNormal];
        [orderButton setBackgroundImage:[UIImage lvImageForBtnRedCornerSel] forState:UIControlStateHighlighted];
        [orderButton setTitle:@"立即预订" forState:UIControlStateNormal];
        [orderButton addTarget:self action:@selector(onlineOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [bottomBar addSubview:orderButton];
}

- (void)updateCollectButtonImage {
    UIButton *collectButton = (UIButton *)[bottomBar viewWithTag:BOTTOM_TAG + 1];
    [collectButton setImage:self.routeProduct.hasIn ? [UIImage imageNamed:@"routeBotCollectSuccess.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] : [UIImage imageNamed:@"routeBotCollect.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
}

#pragma -mark
#pragma -mark requestAdvertiseBehavior DSP浏览
- (void)requestAdvertiseBehavior {
    if ([LvKSharedData kSharedData].referInfo.referTime.length == 0) {
        return;
    }
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
    [requestParams setObject:[LvKSharedData kSharedData].referInfo.refer?:@"" forKey:@"refer"];
    [requestParams setObject:[LvKSharedData kSharedData].lvIDFA?:@""  forKey:@"diviceId"];
    [requestParams setObject:[LvKSharedData kSharedData].referInfo.adid?:@""  forKey:@"adid"];
    [requestParams setObject:@"05002" forKey:@"accessLocus"];
    [requestParams setObject:[NSString stringWithFormat:@"%lld", self.routeProduct.productId] forKey:@"productId"];
    if (self.routeProduct.productDestId > 0) {
        [requestParams setObject:[NSString stringWithFormat:@"%lld", self.routeProduct.productDestId] forKey:@"productDestId"];
    }
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.advertise.behavior" apiVersion:@"1.0.0"];
    setup.methodBack = @"advertiseBehavior";
    setup.isPost = YES;
    setup.indicatorStyle = LVIndicatorStyleNoIndicator;
    [setup changeReqDic:requestParams];
    [self.lvmmNetwork requestVstApiWithSetup:setup];
}

// 获取某个行程的形成结构化接口
- (void)requestOneLineDetailWithParams:(NSMutableDictionary *)params {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSString *lineId = [params objectForKey:@"lineId"];
    [userInfo setObject:lineId forKey:@"lineRouteId"];
    [_isLineRouteRequesting setObject:@(true) forKey:lineId];
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.route.common.product.getOneLineDetail" apiVersion:@"2.0.0"];
    setup.methodBack = @"getOneLineDetail";
    setup.userInfo = userInfo;
    [setup changeReqDic:params];
    setup.indicatorStyle = LVIndicatorStyleNoIndicator;
    [self startActivityIndicatorViewInt:LVIndicatorStyleNoIndicator];
    [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
}

// 请求猜你喜欢 交叉推荐，搜索规则
- (void)requestFavoriteList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.routeProduct.guessToDest.length > 0) {
        [params setObject:self.routeProduct.guessToDest forKey:@"keyword"];
    } else {
        return ;
    }
    NSString *categoryId = @"";
    if ([self.routeProduct.categoryName isEqualToString:@"自由行"]) {
        categoryId = [NSString stringWithFormat:@"%tu,%tu", Category_Route_Hotelcomb, Category_Route_Freedom];
    } else if ([self.routeProduct.categoryName isEqualToString:@"跟团游"]) {
        categoryId = [NSString stringWithFormat:@"%tu", Category_Route_Group];
    } else if ([self.routeProduct.categoryName isEqualToString:@"当地游"]) {
        categoryId = [NSString stringWithFormat:@"%tu", Category_Route_Local];
    }
    if (categoryId.length > 0) {
        [params setObject:categoryId forKey:@"categoryId"];
    }
    [params setObject:[NSNumber numberWithInt:self.routeProduct.lineRouteNumOfDays] forKey:@"routeNum"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:IS_IPAD() ? @"15": @"13" forKey:@"pageSize"];
    if (self.productDestId > 0) {
        [params setObject:[NSString stringWithFormat:@"%lld", self.productDestId] forKey:@"fromDestId"];
    } else {
        [params setObject:[NSString stringWithFormat:@"%d", [[[LVUserDefaultManager sharedUserDefaultManager].routeFromDestDic objectForKey:@"fromDestId"] intValue]] forKey:@"fromDestId"];
    }
    NSString *fromDest = [LVUserDefaultManager sharedUserDefaultManager].cjyFromDestDic[@"name"];
    if (fromDest) {
        [params setObject:fromDest forKey:@"fromDest"];
    }
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.route.search.searchRouteOutbound" apiVersion:@"1.0.0"];
    setup.methodBack = @"searchRouteMethodBack";
    setup.isPost = YES;
    setup.indicatorStyle = LVIndicatorStyleNoIndicator;
    [setup changeReqDic:params];
    [self.lvmmNetwork requestVstApiWithSetup:setup];
}

- (void)requestProductGroupDate {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@"YES" forKey:@"needValidateMethodNameCount"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithLongLong:self.routeProduct.productId] forKey:@"productId"];
    [params setObject:self.routeProduct.routeBizTypeName forKey:@"routeBizType"];
    [params setObject:[NSNumber numberWithLongLong:self.productDestId]  forKey:@"productDestId"];
    [params setObject:self.routeProduct.hasApiFlight?@"true":@"false" forKey:@"hasApiFlight"];
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.route.product.getRouteProductGroupDate" apiVersion:@"2.0.0"];
    setup.isPost = NO;
    setup.methodBack = @"getRouteProductGroupDate";
    setup.userInfo = userInfo;
    [setup changeReqDic:params];
    setup.indicatorStyle = LVIndicatorStyleDefaultIndicator;
    [self startActivityIndicatorViewInt:LVIndicatorStyleDefaultIndicator];
    [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
}

/*!
 *  请求评论信息，分为：点评通知--(无论成功与否)->维度评分（好评率等）--(无论成功与否)->点评内容->当点评条数少于5条时请求：相关点评条数->相关点评列表
 */
- (void)requestCommentData {
    if (firstCommentRequest) {
        [LvmmTagSupport firePageView:[NSString stringWithFormat:@"IP_点评类_产品详情点评_%@",self.routeProduct.buName] cg:CJY_CMBuNameToPinYinCode(@"IP_ProductDetailReviewsList",self.routeProduct.buName) se:@"" sr:@"" attributes:[NSString stringWithFormat:@"%@-_-%@",CMPageAttribute,@"其他页面"] cm_mmc:nil];
        firstCommentRequest = NO; // 避免请求过程中再次发起请求  在请求结束后重新设置
        [self requestCommentNotification:LVIndicatorStyleNoIndicator];
    }
}

// 点评通知接口
- (void)requestCommentNotification:(LVIndicatorStyle)indicatorStyle {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInteger:TAG_REQUEST_VIEW_THREE] forKey:REQUEST_LOADING_VIEW];
    [userInfo setObject:[NSNumber numberWithFloat:50] forKey:REQUESR_LOADING_OFFSET_Y];
    [userInfo setObject:[NSNumber numberWithBool:YES] forKey:@"needValidateMethodNameCount"];
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.cmt.getCmtActivity" apiVersion:@"1.0.0"];
    setup.isPost = NO;
    setup.methodBack = @"getCmtActivityRequest";
    setup.userInfo = userInfo;
    setup.indicatorStyle = indicatorStyle;
    [self.lvmmNetwork requestVstApiWithSetup:setup];
}

// 维度评分接口
- (void)requestLatitudeScoreList:(LVIndicatorStyle)indicatorStyle {
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setObject:[NSString stringWithFormat:@"%lld", self.routeProduct.productId] forKey:@"productId"];
    [reqDic setObject:CMT_TYPE_ROUTE forKey:@"category"];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInteger:TAG_REQUEST_VIEW_THREE] forKey:REQUEST_LOADING_VIEW];
    [userInfo setObject:[NSNumber numberWithFloat:50] forKey:REQUESR_LOADING_OFFSET_Y];
    [userInfo setObject:[NSNumber numberWithBool:YES] forKey:@"needValidateMethodNameCount"];
    
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.cmt.getLatitudeScores" apiVersion:@"1.0.0"];
    setup.isPost = NO;
    [setup changeReqDic:reqDic];
    setup.methodBack = @"requestLatitudeScores";
    setup.userInfo = userInfo;
    setup.indicatorStyle = indicatorStyle;
    [self.lvmmNetwork requestVstApiWithSetup:setup];
}

/*
 - (void)requestAddUserfulCount:(NSString *)commentId {
 LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.cmt.addUsefulCount" apiVersion:@"1.0.0"];
 setup.isPost = NO;
 setup.methodBack = @"requestLatitudeScores";
 [setup changeReqDic:@{@"commentId":commentId}];
 setup.indicatorStyle = LVIndicatorStyleNoIndicator;
 [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
 }
 
 - (void)requestCutUserfulCount:(NSString *)commentId {
 LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.cmt.addUsefulCount" apiVersion:@"1.0.0"];
 setup.isPost = NO;
 setup.methodBack = @"requestLatitudeScores";
 setup.indicatorStyle = LVIndicatorStyleNoIndicator;
 [setup changeReqDic:@{@"commentId":commentId}];
 [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
 }
 */

/*
 产品详情接口 api.com.route.common.product.getRouteDetails v1.0.0
 关于产品基本属性的信息clientProdProductPropBaseVos和listNotice属性，改动如下：
 listNotice属性只会出现在行程prodLineRouteVoList下
 包含属性：费用包含、费用不包含、法务描述、退改规则、出行警示
 
 clientProdProductPropBaseVos属性在产品下
 包含属性：退改说明、交通到达、儿童价描述、产品特色、套餐包含、产品经理推荐、线路产品服务保障、出行警示及说明、是否有大交通、费用包含、费用不含
 
 clientProdProductPropBaseVos属性在行程下
 包含属性：推荐项目（recommended_items）、购物说明（shopping_help）
 */
- (void)updateAllPropDicWithProductBaseVos:(NSArray *)array {
    for (ProdProductPropBase *prodProductPropBase in array) {
        if ([prodProductPropBase.code isEqualToString:PROP_RECOMMEND]) { // 产品经理推荐
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_RECOMMEND];
        } else if ([prodProductPropBase.code isEqualToString:PROP_FEATURE]) { // 产品特色
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_FEATURE];
        } else if ([prodProductPropBase.code isEqualToString:PROP_TRAFFIC_REACH]) { // 交通到达
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_TRAFFIC_REACH];
        }
    }
}

- (void)updateAllPropDicWithProdLineBaseVos:(NSArray *)array {
    for (ProdProductPropBase *prodProductPropBase in array) {
        if ([prodProductPropBase.code isEqualToString:PROP_RECOMMENDED_ITEMS]) { // 推荐项目
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_RECOMMENDED_ITEMS];
        } else if ([prodProductPropBase.code isEqualToString:PROP_SHOPPING_HELP]) { // 购物说明
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_SHOPPING_HELP];
        }
    }
}

- (void)updateAllPropDicWithListNotice:(NSArray * )array {
    for (ProdProductPropBase *prodProductPropBase in array) {
        if ([prodProductPropBase.code isEqualToString:PROP_IMPORTANT]) { // 预订须知
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_IMPORTANT];
        } else if ([prodProductPropBase.code isEqualToString:PROP_LEGAL_PROVISION]) { // 法务描述
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_LEGAL_PROVISION];
        } else if ([prodProductPropBase.code isEqualToString:PROP_CHANGE_AND_CANCELLATION_INSTRUCTIONS]) { // 退款说明
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_CHANGE_AND_CANCELLATION_INSTRUCTIONS];
        } else if ([prodProductPropBase.code isEqualToString:PROP_WARNING]) { // 出行警示及说明
            [self.allPropDic setObject:prodProductPropBase forKey:PROP_WARNING];
        }
    }
}

- (ProdProductPropBase *)getProdProductPropByCode:(NSString *)code {
    return [self.allPropDic objectForKey:code];
}

- (NSString *)getUmengCode:(NSString *)code {
    NSString *string = @"CJY";
    return [string stringByAppendingString:code];
}

- (void)runActivityView {
    [self.webLoadIndicatorView startAnimating];
}

- (UIActivityIndicatorView *)webLoadIndicatorView {
    if (_webLoadIndicatorView==nil) {
        _webLoadIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _webLoadIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_webLoadIndicatorView startAnimating];
    }
    return _webLoadIndicatorView;
}

// 共用一个cell，重新设置frame
- (UITableViewCell *)getSectionNoDateCell:(NSString *)titleString withSection:(NSInteger)section {
    NSString *titleCell = [NSString stringWithFormat:@"titleCell%ld",(long)section];
    UILabel *titleLabel;
    UITableViewCell *cell = [self.cjyTableview dequeueReusableCellWithIdentifier:titleCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell];
        cell.frame = CGRectMake(0, 0, CGRectGetWidth(self.cjyTableview.frame), 30);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.cjyTableview.frame) - 20, CGRectGetHeight(cell.frame))];
        titleLabel.tag = 100;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
    } else {
        titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
    }
    cell.backgroundColor = [UIColor lvColorWithHexadecimal:kColorMainWhite];
    titleLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
    titleLabel.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
    titleLabel.text = titleString;
    return cell;
}

// 抱歉，当前产品没有行程内容
- (UITableViewCell *)createNoticeCellWithTableView:(UITableView *)ttableView {
    static NSString *noticeCellIdentifier = @"noticeCellIdentifier";
    UITableViewCell *noticeCell = [ttableView dequeueReusableCellWithIdentifier:noticeCellIdentifier];
    if (!noticeCell) {
        noticeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeCellIdentifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen lvScreenWidth], 100)];
        headerView.backgroundColor = [UIColor clearColor];
        UIImageView *iconImagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lvDefault.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]];
        iconImagView.frame = CGRectMake(([UIScreen lvScreenWidth] - 55) / 2, 5, 55, 55);
        [headerView addSubview:iconImagView];
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, [UIScreen lvScreenWidth], 20)];
        noticeLabel.numberOfLines = 0;
        noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        noticeLabel.text = @"抱歉，当前产品没有行程内容";
        noticeLabel.backgroundColor = [UIColor clearColor];
        noticeLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
        noticeLabel.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
        noticeLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:noticeLabel];
        [noticeCell addSubview:headerView];
    }
    return noticeCell;
}

// 查看更多交通信息
-(UITableViewCell *)getMoreTrafficCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *moreCellIdentifier = @"moreCellIdentifier";
    UITableViewCell *moreCell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
    if (!moreCell) {
        moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentifier];
        UILabel *moreLabel = [[UILabel alloc] init];
        moreLabel.backgroundColor = [UIColor clearColor];
        moreLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
        moreLabel.font = [UIFont lvFontWithHelveticaSize:kFontSecond16];
        moreLabel.frame = CGRectMake(10, 0, [UIScreen lvScreenWidth] - 30, 44);
        moreLabel.text = @"查看更多交通信息";
        [moreCell.contentView addSubview:moreLabel];
    }
    moreCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:moreCell.bounds withDataSourceCount:1 withIndex:indexPath.row isPlain:YES needArrow:YES isSelected:NO];
    return moreCell;
}

#pragma mark -
#pragma mark ---- LVMMNetworkManagerDelegate ----
- (void)lvmmRequestFinished:(LVMMRequestSetup *)request {
    NSDictionary *dictionary = request.responseObject;
    LVLog(@"dacaiguoguo:\n%s\n%@\n%@",__func__,request.methodBack,@"");
    if ([@"-2" isEqualToString:request.code]) {
        [self stopActivityIndicatorViewInt:request.indicatorStyle];
        self.cjyTableview.noDataText = [dictionary objectForKey:@"message"];
        [self reloadTableviewData];
        return;
    }
    
    NSString *errorMsg = request.errorMessage;
    if (errorMsg || !dictionary) {
        if ([request.methodBack isEqualToString:@"getCmtActivityRequest"]) {
            [self requestLatitudeScoreList:LVIndicatorStylePartialIndicator];
        } else {
            if ([errorMsg length] > 0) {
                [[LVDialogMessage sharedDialogMessage] showMessage:errorMsg messageType:MessageFail];
            }
            if ([request.methodBack isEqualToString:@"getOneLineDetail"]) {
                NSString *lineId = [request.userInfo valueForKey:@"lineRouteId"];
                [_isLineRouteRequesting setObject:@(false) forKey:lineId];
            }
            [self stopActivityIndicatorViewInt:request.indicatorStyle];
        }
        
        return;
    }
    
    self.detailWebview.hidden = NO;
    if ([request.methodBack isEqualToString:@"getRouteProductGroupDate"]) {
        [self stopActivityIndicatorViewInt:request.indicatorStyle];
        self.routeProduct.lineDetailUrl = [LvmmCjyCommonFunction getValueFromDic:request.dictionaryData withKey:@"lineDetailUrl"];
        [timePriceArray removeAllObjects];
        for (NSMutableDictionary *dic in [request.dictionaryData objectForKey:@"list"]) {
            TimePrice *timePrice = [TimePrice parseFromJsonDictionary:dic];
            [timePriceArray addObject:timePrice];
        }
        self.routeProduct.extra = [LvmmCjyCommonFunction getValueFromDic:request.dictionaryData withKey:@"extra"];//儿童描述
        self.routeProduct.suppChildOnSaleFlag = [[request.dictionaryData objectForKey:@"suppChildOnSaleFlag"] boolValue];//儿童禁售
        self.routeProduct.remarks = [LvmmCjyCommonFunction getValueFromDic:request.dictionaryData withKey:@"remarks"];//起价说明
        if ([timePriceArray count] > 0) {
            [self goCalendar];
        }
    } else if ([request.methodBack isEqualToString:@"getOneLineDetail"]) {
        NSString *lineRouteIdStr = [request.userInfo objectForKey:@"lineRouteId"];
        [_isLineRouteRequesting setObject:@(false) forKey:lineRouteIdStr];
        ProdLineRoute *prodLineRoute = [ProdLineRoute parseFromJsonDictionary:request.dictionaryData];
        [prodLineRouteDic setObject:prodLineRoute ? prodLineRoute :[[ProdLineRoute alloc] init] forKey:lineRouteIdStr]; // 用lineRouteId当键保存行程对象
        // 当前选中行程和这个行程的id一致
        if (prodLineRoute.lineRouteId == currentProdLineRouteVo.lineRouteId) {
            currentProdLineRoute = prodLineRoute;
            [self reloadTableviewData];
        }
    }  else if ([request.methodBack isEqualToString:@"getScenicDetail"] || [request.methodBack isEqualToString:@"getHotelDetail"]) {
        [self stopActivityIndicatorViewInt:request.indicatorStyle];
        NSArray *nib = [[NSBundle bundleForClass:CjyDetailActivityView.class] loadNibNamed:@"CjyDetailActivityView" owner:self options:nil];
        CjyDetailActivityView *view = [nib objectAtIndex:0];
        view.detailType = [request.methodBack isEqualToString:@"getScenicDetail"] ? RouteDetailActivityPlaceType:RouteDetailActivityHotelType;
        view = [view initWithDetailArray:(NSMutableDictionary *)request.dictionaryData];
        CGRect tmpFrame = [[UIScreen mainScreen] bounds];
        [view setFrame:CGRectMake(0, 0, tmpFrame.size.width, tmpFrame.size.height)];
        [view show];
    } else if ([request.methodBack isEqualToString:@"requestLatitudeScores"]) {
        NSMutableArray  *pcsVoList = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dic in [request.dictionaryData objectForKey:@"clientLatitudeStatistics"]) {
            CmtScore *cmtScore = [CmtScore parseFromJsonDictionary:dic];
            [pcsVoList addObject:cmtScore];
        }
        self.routeProduct.pcsVoList = pcsVoList;
        [self reloadTableviewData];
    } else if([request.methodBack isEqualToString:@"getCmtActivityRequest"]) {
        for (NSMutableDictionary *dic in request.arrayData) {
            if ([[dic objectForKey:@"type"] isEqualToString:@"act_notice"]) {
                cmtActivity = [CmtActivity parseFromJsonDictionary:dic];
            }
        }
        [self requestLatitudeScoreList:LVIndicatorStylePartialIndicator];
    } else if ([request.methodBack isEqualToString:@"searchRouteMethodBack"]) {
        //        [super requestFinished:request];
        for (NSMutableDictionary *routeProductDic in [request.dictionaryData objectForKey:@"routeList"]) {
            RouteProduct *routeProduct = [RouteProduct parseFromJsonDictionary:routeProductDic];
            // 过滤当前产品
            if (routeProduct.productId != self.routeProduct.productId) {
                [routeProductArray addObject:routeProduct];
            }
        }
        if (routeProductArray.count > 0) {
            recommentPageScrollView = [[CjyRecommentPageScrollView alloc] initWithParamsArray:routeProductArray];
            recommentPageScrollView.routeSelectDelegate = self;
            bottomHeight += 30 + CGRectGetHeight(recommentPageScrollView.bounds);
        }
        [self rhinoStatIsFst:NO];
    }
}

- (void)lvmmRequestFailed:(LVMMRequestSetup * _Nonnull )request {
    
    if ([request.methodBack isEqualToString:@"getCmtActivityRequest"]) {
        [self requestLatitudeScoreList:LVIndicatorStylePartialIndicator];
    } else {
        [self stopActivityIndicatorViewInt:request.indicatorStyle];
        if ([request.methodBack isEqualToString:@"getOneLineDetail"]) {
            NSString *lineId = [request.userInfo objectForKey:@"lineRouteId"];
            [_isLineRouteRequesting setObject:@(false) forKey:lineId];
        }
    }
}

#pragma mark - UIScrollView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([[webView.request.URL absoluteString] hasSuffix:@"blank.html"]) {
        [self.detailWebview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F8F8F8'"];
        ProdProductPropBase *prodProductPropBase = [self getProdProductPropByCode:PROP_FEATURE];
        [self.detailWebview lvmmLoadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:prodProductPropBase.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.f]];
        return;
    }
    [self.detailWebview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#FFFFFF'"];
    [self.webLoadIndicatorView stopAnimating];
    [self reloadTableviewData];
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self reloadTableviewData];
    });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.detailWebview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#FFFFFF'"];
    [self.webLoadIndicatorView stopAnimating];
    loadFailView.hidden = NO;
    if (!loadFailView.hidden) {
        if (loadFailView.superview) {
            [loadFailView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.detailWebview).offset(-self.detailWebview.scrollView.contentOffset.y);
            }];
        }
    }
    [self reloadTableviewData];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.tapViewSectionIndex) {
        return floorf(CGRectGetHeight(self.tapView.bounds));
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.tapViewSectionIndex) {
        return self.tapView;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.cellArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RouteCjyDetailBaseViewModel *viewModel = [[self.cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return viewModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RouteCjyDetailBaseViewModel *viewModel = [[self.cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return [viewModel tableView:tableView cellForRowAtIndexPath:indexPath delegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RouteCjyDetailBaseViewModel *viewModel = [[self.cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self didSelectModel:viewModel];
    //理解、反应、操作、意识、策略、执行力
    //伪装、思辨、诱导、
    [self reloadTableviewData];
}

- (void)didSelectModel:(RouteCjyDetailBaseViewModel *)viewModel {
    [viewModel didSelectCellTableView:self.cjyTableview viewController:self];
    
    // 行程
    if ([viewModel.selectId isEqualToString:kRouteCjyDetailTrafficMoreSelectId]) {//点击查看更多交通信息
        RouteCjyLineDetailView *lineDetailView = [[RouteCjyLineDetailView alloc] init];
        [lineDetailView showWithUrl:self.routeProduct.trafficGroupsUrl];
    } else if ([viewModel.selectId isEqualToString:kRouteCjyDetailLineMoreSelectId]) {//点击查看线路的图文详情
        [self picTextAction];
    } else if ([viewModel.selectId isEqualToString:kRouteCjyDetailPMRecommendSelectId]) {//点击产品经理推荐
        recommendReasonCell.isExpand = !recommendReasonCell.isExpand;
    } else if ([viewModel.selectId isEqualToString:kRouteCjyDetailAnnouncementSelectId]) {//点击公告kRouteGnyDetailRelatedTravelSelectId
        announcementCell.isExpand = !announcementCell.isExpand;
    } else if ([viewModel.selectId isEqualToString:kRouteCjyDetailStampProductSelectId]) {//点击预售产品
        [LvmmTagSupport fireElement:[NSString stringWithFormat:@"IP_%@_%@_预售产品按钮点击",self.routeProduct.categoryName,self.routeProduct.buName] ecat:@"IP预售" attributes:@""];
        
        UIViewController *vc = [[LVMediator sharedMediator] LVMediator_FocusWebViewControllerWithUrl:self.routeProduct.stampGroupsUrl];
        [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
    } else if ([viewModel isKindOfClass:[RouteCjyDetailDateChooseViewModel class]]) { // 选择日期
        [self gnyDateChooseviewModelDidClickMoreDate:(RouteCjyDetailDateChooseViewModel *)viewModel];
    } else if ([viewModel.selectId isEqualToString:kRouteCjyDetailDepartureSelectId]) {//点击更多出发地
        if (self.routeProduct.fromDest.length > 0 && self.routeProduct.multipleDeparture && self.routeProduct.multipleDeparture.count > 0) {
            __weak typeof(self) weakSelf = self;
            RouteCjySelectDepartureViewController *vc = [[RouteCjySelectDepartureViewController alloc] init];
            vc.postParams = @{@"multipleDeparture": self.routeProduct.multipleDeparture, @"currentDeparture": self.routeProduct.fromDest, @"changeDistrict": ^(ClientSimpleDistrictVo *selectDistrictVo){
                [weakSelf.delegate reloadDetailWithViewController:self productDestId:selectDistrictVo.districtId];
            }};
            [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
        }
    }
    //    else if([viewModel.selectId isEqualToString:kRouteCjyDetailProductFeatureMoreSelectId]){
    //        //如果是查看更多按钮被点击了，将其标记位置反
    //        self.hasShowMoreProdFeather = !self.hasShowMoreProdFeather;
    //    }
}

#pragma mark -
#pragma mark -------- 按钮事件 ---------
- (void)favorAction {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    if ([_delegate respondsToSelector:@selector(requestDetailCollectAction)]) {
        [_delegate requestDetailCollectAction];
    }
}
- (void)onlineOrderAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    if (self.routeProduct.phoneFlag) {
        [self callLvmamaNumber:NO];
        return;
    }
    [WapperUM event:[self getUmengCode:@"046"]];
    [LvmmTagSupport fireElement:@"IP出境游_立即预订" ecat:@"APP立即预订按钮" attributes:@""];
    if ([timePriceArray count] == 0) {
        [self requestProductGroupDate];
    } else {
        [self goCalendar];
        if (self.selectedDateString.length > 0) {
            self.selectedDateString = @"";
        }
    }
}

- (void)saveBrowseCache {
    [[LVMediator sharedMediator] LVMediator_RouteBrowseHistoryControllerWithRouteProduct:self.routeProduct];
}

- (void)callLvmama {
    [WapperUM event:[self getUmengCode:@"341"]];
    [LvmmTagSupport fireElement:@"IP_出境游-客服" ecat:@"IP出境游客服拨打" attributes:@""];
    
    [ServicePhoneCallManager callCustomerLvmama:ActionSheetTag_CallLvmama];
    [self hideView];
}

- (void)callLvmamaCjy {
    [WapperUM event:[self getUmengCode:@"341"]];
    [LvmmTagSupport fireElement:@"IP_出境游-客服" ecat:@"IP出境游客服拨打" attributes:@""];
    
    [ServicePhoneCallManager callCustomerLvmama:ActionSheetTag_CallLvmamaShip];
    [self hideView];
}

#pragma mark RouteCjyDetailDateChooseViewModelDelegate 日历价格表

- (void)gnyDateChooseviewModel:(RouteCjyDetailDateChooseViewModel *)model didSelectDate:(ProdGroupDateVo *)prodGroupDateVo {
    self.selectedDateString = [prodGroupDateVo.departureDate copy];
    [self selectCalendar];
}

- (void)gnyDateChooseviewModelDidClickMoreDate:(RouteCjyDetailDateChooseViewModel *)model {
    [self selectCalendar];
}

- (void)selectCalendar {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    
    [WapperUM event:[self getUmengCode:@"041"]];
    if ([timePriceArray count] == 0) {
        [self requestProductGroupDate];
    } else {
        [self goCalendar];
    }
}

- (void)goCalendar {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:timePriceArray forKey:@"timePriceArray"];
    if ([(TimePrice *)[timePriceArray objectAtIndex:0] specDate]) {
        [params setObject:[(TimePrice *)[timePriceArray objectAtIndex:0] specDate] forKey:@"defaultdDateValue"];
    }
    [params setObject:self.routeProduct forKey:@"routeProduct"];
    //V7.5.0 出境游品类当地游下单
    if (self.routeProduct.bizCategoryId == Category_Route_Local) {
        // 出境游 当地游品类 不传选中日期
        self.routeProduct.routeBizType = TravelType_ZBY;
        UIViewController *vc = [[LVMediator sharedMediator] LVMediator_CalendarZbyViewControllerWithParams:params];
        [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
    } else {
        // 传选中日期
        if (self.selectedDateString.length > 0) {
            [params setObject:self.selectedDateString forKey:@"selectedDateValue"];
        }
        
        TimePrice *timePrice = (TimePrice *)timePriceArray.firstObject;
        UIViewController *vc = [[LVMediator sharedMediator] LVMediator_CalendarCjyViewControllerWithTimePriceArray:timePriceArray DefaultdDateValue:timePrice RouteProduct:self.routeProduct SelectedDateValue:self.selectedDateString];
        
        [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
    }
}

- (IBAction)refreshDetail:(id)sender {
    if ([LVMMNetworkStatusManager sharedNetworkStatusManager].networkType == LVNetworkType_None) {
        [super showNetworkNoneView];
        return;
    }
    
    loadFailView.hidden = YES;
    [self runActivityView];
    ProdProductPropBase *prodProductPropBase = [self getProdProductPropByCode:PROP_FEATURE];
    [self.detailWebview lvmmLoadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:prodProductPropBase.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.f]];
}

//返回顶部
- (void)topAction {
    [self.cjyTableview lvScrollToRow0Section0AtScrollPosition:UITableViewScrollPositionTop animated:YES];
    LVLog(@"返回顶部");
}

// 跳转图文详情
- (void)picTextAction {
    if (currentProdLineRoute.lineDetailUrl.length == 0) {
        return;
    }
    NSString *detailUrl = currentProdLineRoute.lineDetailUrl;
    RouteCjyLineDetailView *lineDetailView = [[RouteCjyLineDetailView alloc] init];
    [lineDetailView showWithUrl:detailUrl];
}

#pragma mark - CommentImageDidClicked Methods
- (void)commentImageDidClickedAtIndex:(NSInteger)index withImageUrls:(NSArray *)imageUrls {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    ScrollImageViewer *imageViewer = [[ScrollImageViewer alloc] init];
    
    if (self.routeProduct.hasVideo) {
        if (index == 0) {
            //播放视频
            NSString *videoId = [self.routeProduct.videos.firstObject objectForKey:@"videoCcId"];
            UIViewController *vc = [[LVMediator sharedMediator] LVMediator_RouteCjySearchVideoPlayerControllerWithVideoId:videoId];
            
            LVNavigationController *navigationController = [[LVNavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:navigationController animated:NO completion:nil];
        } else {
            [imageViewer showWithImageUrlsString:imageUrls selectedIndex:index];
        }
    } else {
        [imageViewer showWithImageUrlsString:imageUrls selectedIndex:index];
    }
}

#pragma mark - BaseTapViewDelegate
- (void)tapViewClicked:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    
    if (index < self.detailTabbarFirstIndexArray.count) {
        NSIndexPath *indexPath = [self.detailTabbarFirstIndexArray objectAtIndex:index];
        self.scrollingIndexPath = indexPath;
        [self.cjyTableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollingIndexPath = nil;
        });
    }
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    // 图文详情和tapview
    [self updatePicTextButton];
    if (scrollView.dragging) {
        [self updateTapViewSelectedIndex];
    }
    // 上移高度大于一屏显示回到顶部按钮
    if (floorf(self.cjyTableview.contentOffset.y) >= [UIScreen lvScreenHeight]) {
        backTopButton.hidden = NO;
    } else {
        backTopButton.hidden = YES;
    }
    
    if ([_delegate respondsToSelector:@selector(resetDetailNavigationWithOffset:)]) {
        [_delegate resetDetailNavigationWithOffset:scrollView.contentOffset.y];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTapViewSelectedIndex];
        [self reloadTableviewData];
    });
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTapViewSelectedIndex];
        [self reloadTableviewData];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTapViewSelectedIndex];
        [self reloadTableviewData];
    });
}

/*!
 *  检查当前的selectIndex
 */
- (void)updateTapViewSelectedIndex {
    // 设置tapView的selectedIndex
    NSIndexPath *indexPath = [self.cjyTableview indexPathForRowAtPoint:CGPointMake(0, CGRectGetMaxY(self.tapView.frame) + 2)];
    NSInteger currentPriority = indexPath.section * 1000 + indexPath.row;
    NSInteger minPriority = 0;
    int selectIndex = (int)self.detailTabbarFirstIndexArray.count - 1;
    for (int index = 1; index < self.detailTabbarFirstIndexArray.count; index ++) {
        NSIndexPath *maxIndexPath = [self.detailTabbarFirstIndexArray objectAtIndex:index];
        NSInteger maxPriority = maxIndexPath.section * 1000 + maxIndexPath.row;
        if (currentPriority >= minPriority  && currentPriority < maxPriority) {
            selectIndex = index - 1;
        }
        minPriority = maxPriority;
    }
    self.tapView.selectedIndex = selectIndex;
}

/*!
 *  行程的图文详情按钮显示条件：1.tab栏数据在当前屏显示 2.图文详情链接不为空
 *  当行程在最后一个时这时行程结束点为该section的最后一行
 */
- (void)updatePicTextButton {
    int routeIndex = -1;//新车在detailTabbarFirstIndexArray第几个位置
    for (int index = 0; index < self.tapViewTypeArray.count; index ++) {
        kRouteCjyTapViewType type = [[self.tapViewTypeArray objectAtIndex:index] integerValue];
        if (type == kRouteCjyTapViewTypeRoute) {
            routeIndex = index;
            break;
        }
    }
    // 当前没有行程信息
    if (routeIndex < 0) {
        picTextButton.hidden = YES;
        return;
    }
    
    CGPoint startPoint;
    CGPoint endPoint;
    if (self.detailTabbarFirstIndexArray.count > routeIndex + 1) {
        NSIndexPath *start = [self.detailTabbarFirstIndexArray objectAtIndex:routeIndex];
        NSIndexPath *end = [self.detailTabbarFirstIndexArray objectAtIndex:routeIndex + 1];
        startPoint = [LvmmCjyCommonFunction safeTableView:self.cjyTableview rectForRowAtIndexPath:start].origin;
        endPoint = [LvmmCjyCommonFunction safeTableView:self.cjyTableview rectForRowAtIndexPath:end].origin;
    }else {
        NSIndexPath *start = [self.detailTabbarFirstIndexArray objectAtIndex:routeIndex];
        NSIndexPath *end = [NSIndexPath indexPathForRow:[self.cjyTableview numberOfRowsInSection:start.section] - 1 inSection:start.section];
        startPoint = [LvmmCjyCommonFunction safeTableView:self.cjyTableview rectForRowAtIndexPath:start].origin;
        CGRect endRect = [LvmmCjyCommonFunction safeTableView:self.cjyTableview rectForRowAtIndexPath:end];
        endPoint = CGPointMake(0, CGRectGetMaxY(endRect));
    }
    CGFloat startYBounds = [self.cjyTableview convertPoint:startPoint toView:nil].y;
    CGFloat endYBounds = [self.cjyTableview convertPoint:endPoint toView:nil].y;
    // 当行程内容minY到maxY之间显示，即在屏幕的0.3和0.7之间有行程内容则显示
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat minY = screenHeight * 0.3;
    CGFloat maxY = screenHeight * 0.7;
    picTextButton.hidden = !(startYBounds < maxY && endYBounds > minY && currentProdLineRoute.lineDetailUrl.length > 0);
}

#pragma -mark
#pragma -mark callLvmamaNumber

- (void)callCjyLvmamaNumber {
    [LvmmTagSupport fireElement:@"IP_出境游-客服" ecat:@"IP出境游客服拨打" attributes:@""];
    [self callLvmamaNumber:YES];
}

- (void)callLvmamaNumber:(BOOL)isCjyService {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    if (![self.view viewWithTag:-1100]) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen lvScreenWidth], [UIScreen lvScreenHeight])];
        grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        [window addSubview:grayView];
        grayView.hidden = NO;
        grayView.tag = -1100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        [grayView addGestureRecognizer:tap];
        
        UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(window.bounds) - 205, CGRectGetWidth(window.bounds), 205)];
        filterView.tag = -1200;
        filterView.backgroundColor = [UIColor lvColorWithHexadecimal:kColorMainWhite];
        [window addSubview:filterView];
        filterView.hidden = NO;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(filterView.bounds), 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
        titleLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextDarkGray];
        titleLabel.text = @"为了节约您的时间，请告知客服产品编号";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [filterView addSubview:titleLabel];
        
        UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(filterView.bounds), 30)];
        productLabel.backgroundColor = [UIColor clearColor];
        productLabel.font = [UIFont lvFontWithHelveticaSize:kFontForth14];
        productLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextBlack];
        productLabel.text = [NSString stringWithFormat:@"产品编号 %lld",self.routeProduct.productId];
        productLabel.textAlignment = NSTextAlignmentCenter;
        [filterView addSubview:productLabel];
        
        UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        callButton.frame = CGRectMake(10, CGRectGetMaxY(productLabel.frame) + 10, CGRectGetWidth(self.view.bounds) - 20, 44);
        [callButton setBackgroundColor:[UIColor lvColorWithHexadecimal:kColorMainRed]];
        [callButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorMainWhite] forState:UIControlStateNormal];
        [callButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorMainWhite] forState:UIControlStateSelected];
        callButton.titleLabel.font = [UIFont lvFontWithHelveticaSize:kFontSecond16];
        //        [callButton setTitle:[NSString stringWithFormat:@"拨打%@(免长话费)", isCjyService ? MESSAGE_LVMAMA_TEL_NEW : MESSAGE_LVMAMA_TEL] forState:UIControlStateNormal];
        [callButton setTitle:[NSString stringWithFormat:@"拨打%@(免长话费)", isCjyService ? @"4006040699" : @"4001570570"] forState:UIControlStateNormal];
        
        if (isCjyService) {
            [callButton addTarget:self action:@selector(callLvmamaCjy) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [callButton addTarget:self action:@selector(callLvmama) forControlEvents:UIControlEventTouchUpInside];
        }
        [filterView addSubview:callButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(10, CGRectGetMaxY(callButton.frame) + 20, CGRectGetWidth(self.view.bounds) - 20, 44);
        [cancelButton setBackgroundColor:[UIColor lvColorWithHexadecimal:kColorTextLightGray]];
        [cancelButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorMainWhite] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor lvColorWithHexadecimal:kColorMainWhite] forState:UIControlStateSelected];
        cancelButton.titleLabel.font = [UIFont lvFontWithHelveticaSize:kFontSecond16];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [filterView addSubview:cancelButton];
    }
}

- (void)hideView {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *filterView = (UIView *)[window viewWithTag:-1200];
    UIView *grayView = (UIView *)[window viewWithTag:-1100];
    for (UIView *subView in filterView.subviews) {
        [subView removeFromSuperview];
    }
    [filterView removeFromSuperview];
    [grayView removeFromSuperview];
}

#pragma mark -
#pragma mark RecommentPageScrollViewDelegate 猜你喜欢
- (void)didSelectCommentRouteWithParams:(id)params {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    
    for (NSInteger i = 0; i < routeProductArray.count; i++) {
        RouteProduct *product = [routeProductArray objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%zd",product.productId] isEqualToString:[[params objectForKey:@"productId"] stringValue]]) {
            NSInteger pageIndex = i / 4 + 1;
            NSInteger itemIndex = i % 4 + 1;
            [LvmmTagSupport fireElement:[NSString stringWithFormat:@"IP_详情页_猜你喜欢-%zd-00%zd",pageIndex,itemIndex] ecat:@"IP_我的" attributes:@""];
            break;
        }
    }
    
    //走内部losc存储
    NSMutableDictionary *loscDic = [NSMutableDictionary dictionary];
    [loscDic setObject:@"073001" forKey:@"losc"];
    [ReferLoscUtil resetLoscInfo:loscDic withIsInnerLosc:YES];
    
    [WapperUM event:[self getUmengCode:@"098"]];
    NSMutableDictionary *routParams = [NSMutableDictionary dictionary];
    NSString *productIdStr = [params objectForKey:@"productId"];
    if (productIdStr) {
        [routParams setObject:productIdStr forKey:@"productId"];
    } else {
        return;
    }
    if ([params[@"productDestId"] longLongValue] > 0) {
        [routParams setObject:params[@"productDestId"] forKey:@"productDestId"];
    }
    NSString *routeDataFrom = [params objectForKey:@"routeDataFrom"];
    if ([routeDataFrom isEqualToString:@"TUANGOU"] ||
        [routeDataFrom isEqualToString:@"SECKILL"]) {
        [routParams setObject:@"PROD" forKey:@"branchType"];
        
        UIViewController *vc = [[LVMediator sharedMediator] LVMediator_GrouponDetailViewControllerWithParams:routParams];
        [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
    } else {
        UIViewController *vc = [[LVMediator sharedMediator] LVMediator_RouteDetailViewControllerWithProductId:[NSNumber numberWithLongLong:[productIdStr longLongValue]] withProductDestId:params[@"productDestId"]];
        [[LVAdapterManager currentNavigationService] pushVC:vc animated:YES];
    }
}

#pragma mark -
#pragma mark ProdLineRouteVoChooseCellDelegate
- (void)updateProdLineRouteWithIndex:(NSInteger)btnIndex {
    if ([_delegate respondsToSelector:@selector(hideNavigationView)]) {
        [_delegate hideNavigationView];
    }
    // 切换行程时更新数据 （属性列表、时间价格表、行程结构化、须知）
    prodLineSelectIndex = btnIndex;
    currentProdLineRouteVo = (ProdLineRouteVo *)self.routeProduct.prodLineRouteVoList[prodLineSelectIndex];
    
    self.journeyDaysVM.journeyNumOfDays = [NSString stringWithFormat:@"%tu天%tu晚", currentProdLineRouteVo.routeNum, currentProdLineRouteVo.stayNum];
    self.journeyDaysVM.departureDateArr = currentProdLineRouteVo.groupDateVoInFive;//ProdGroupDateVo
    //    // 刷新Tabels
    //    __weak typeof(self) weakSelf = self;
    //    self.journeyDaysVM.block = ^(){
    //        [self reloadTableviewData];
    //    };
    
    // 属性列表
    [self updateAllPropDicWithProdLineBaseVos:currentProdLineRouteVo.clientProdProductPropBaseVos];
    [self updateAllPropDicWithListNotice:currentProdLineRouteVo.listNotice];
    NSString *lineRouteIdStr = [NSString stringWithFormat:@"%lld", currentProdLineRouteVo.lineRouteId];
    if ([prodLineRouteDic objectForKey:lineRouteIdStr]) {
        currentProdLineRoute = [prodLineRouteDic objectForKey:lineRouteIdStr];
    } else {
        // 请求当前行程的行程结构化接口
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSString stringWithFormat:@"%lld", self.routeProduct.productId] forKey:@"productId"];
        [params setObject:[NSString stringWithFormat:@"%lld", currentProdLineRouteVo.lineRouteId] forKey:@"lineId"];
        [self requestOneLineDetailWithParams:params];
    }
    // 须知 费用包含、不包含
    if (!routeNoticeCell) {
        if (currentProdLineRouteVo.listNotice.count > 0) {
            routeNoticeCell = [[CjyNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"routeGnyNoticeCell"
                                                withGnyNoticeArray:[currentProdLineRouteVo.listNotice copy]
                                                  withContentWidth:screenWidth];
        }
    } else {
        if (currentProdLineRouteVo.listNotice.count > 0) {
            [routeNoticeCell updateRouteNoticeCellWithGnyNoticeArray:[currentProdLineRouteVo.listNotice copy]
                                                    withContentWidth:screenWidth];
        } else {
            routeNoticeCell = nil;
        }
    }
    // 刷新Tabels
    [self updateTablesHasTrip:currentProdLineRouteVo.prodLineRouteDetailVoList.count > 0];
}

#pragma mark -
#pragma mark GeneralDetailGroupCellDelegate
- (void)forwardToScenic:(NSString *)scenicId {
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setObject:scenicId forKey:@"id"];
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.route.common.product.getScenicDetail" apiVersion:@"2.0.0"];
    setup.isPost = NO;
    setup.methodBack = @"getScenicDetail";
    [setup changeReqDic:params];
    setup.indicatorStyle = LVIndicatorStyleDefaultIndicator;
    [self startActivityIndicatorViewInt:LVIndicatorStyleDefaultIndicator];
    [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
}

- (void)forwardToHotel:(NSString *)hotelId {
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setObject:hotelId forKey:@"id"];
    LVMMRequestSetup *setup = [[LVMMRequestSetup alloc] initWithApiMethod:@"api.com.route.common.product.getHotelDetail" apiVersion:@"2.0.0"];
    setup.isPost = NO;
    setup.methodBack = @"getHotelDetail";
    [setup changeReqDic:params];
    setup.indicatorStyle = LVIndicatorStyleDefaultIndicator;
    [self startActivityIndicatorViewInt:LVIndicatorStyleDefaultIndicator];
    [self.lvmmNetwork requestVstRouteApiWithSetup:setup];
}

#pragma mark -
#pragma mark Initial
- (LVMMNetwork *)lvmmNetwork {
    if (!_lvmmNetwork) {
        self.lvmmNetwork = [[LVMMNetwork alloc] init];
        _lvmmNetwork.userAgent = [LVMMRequestWeiba lvmmUserAgent];
        _lvmmNetwork.delegate = self;
    }
    return _lvmmNetwork;
}

@end
