//
//  TourDepartureDateAndTouristsPresentor.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateAndTouristsPresentor.h"
#import "RouteCjyDetailImageTitleViewModel.h"
#import "TourDepartureDateCollectionController.h"
#import "TourDepartureDateTouristsCell.h"
#import "BaseRouteCjyDetailCell.h"
#import "GroupedCellBgView.h"



@interface TourDepartureDateAndTouristsPresentor()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) BaseRouteCjyDetailCell *titleCell;

@property (nonatomic, strong) UITableViewCell *tourDepartureDateCell;

@property (nonatomic, strong) TourDepartureDateTouristsCell *touristsCell;

@property (nonatomic, strong) TourDepartureDateCollectionController *tourVC;
@end

//static CGFloat const FOOT_HEIGHT = 10;

@implementation TourDepartureDateAndTouristsPresentor

+ (instancetype)presentorWithTableView:(UITableView *)tableView {
    TourDepartureDateAndTouristsPresentor *presentor = [[TourDepartureDateAndTouristsPresentor alloc] init];
    presentor.tableView = tableView;
    return presentor;
}

#pragma mark - Getter
- (NSArray *)viewModels {
    
    NSMutableArray *sectionTourDepartureDateAndTourists = [NSMutableArray array];

    RouteCjyDetailImageTitleViewModel *titleVM = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:nil title:@"选择出游人数和日期" detailText:@"更改" arrow:YES];
    [sectionTourDepartureDateAndTourists addObject:titleVM];
    
    
    RouteCjyDetailBaseViewModel *tourDepartureDateVM = [[RouteCjyDetailBaseViewModel alloc]initWithCell:self.tourDepartureDateCell cellHeight:55];
    [sectionTourDepartureDateAndTourists addObject:tourDepartureDateVM];
    
    
    RouteCjyDetailBaseViewModel *touristsVM = [[RouteCjyDetailBaseViewModel alloc]initWithCell:self.touristsCell cellHeight:65];
    
    [sectionTourDepartureDateAndTourists addObject:touristsVM];
    
//    [sectionTourDepartureDateAndTourists addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    return [sectionTourDepartureDateAndTourists copy];
}

- (BaseRouteCjyDetailCell *)titleCell {
    if (!_titleCell) {
        static NSString *reuseID = @"tourDepartureDateAndTouristsTitleCellReuseIdentifier";
        self.titleCell = [[BaseRouteCjyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return _titleCell;
}


- (UITableViewCell *)tourDepartureDateCell {
    if (!_tourDepartureDateCell) {
        static NSString *reuseID = @"tourDepartureDateCellReuseIdentifier";
        self.tourDepartureDateCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        self.tourVC.collectionView.frame = self.tourDepartureDateCell.frame;
        [self.tourDepartureDateCell.contentView addSubview:self.tourVC.collectionView];
        self.tourDepartureDateCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:true needArrow:false isSelected:false];
    }
    return _tourDepartureDateCell;
}

- (TourDepartureDateTouristsCell *)touristsCell {
    if (!_touristsCell) {
        static NSString *reuseID = @"touristsCellReuseIdentifier";
        self.touristsCell = [[TourDepartureDateTouristsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return _touristsCell;
}

- (TourDepartureDateCollectionController *)tourVC {
    if (!_tourVC) {
        self.tourVC = [[TourDepartureDateCollectionController alloc]init];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(74, 34);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //item之间的距离
        flowLayout.minimumInteritemSpacing = 10;
        
        NSMutableArray *products = [NSMutableArray array];
        for (NSInteger index = 0; index < 25; index ++) {
            NSObject *product = [[NSObject alloc] init];
            [products addObject:product];
        }
        
        self.tourVC = [[TourDepartureDateCollectionController alloc] initWithCollectionViewLayout:flowLayout Products:products];
        
        self.tourVC.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _tourVC;
}

@end
