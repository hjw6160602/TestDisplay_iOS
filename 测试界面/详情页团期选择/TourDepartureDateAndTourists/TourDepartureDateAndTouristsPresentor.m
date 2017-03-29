//
//  TourDepartureDateAndTouristsPresentor.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateAndTouristsPresentor.h"
#import "RouteCjyDetailImageTitleViewModel.h"
#import "BaseRouteCjyDetailCell.h"
#import "GroupedCellBgView.h"

@interface TourDepartureDateAndTouristsPresentor()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) BaseRouteCjyDetailCell *titleCell;

@property (nonatomic, strong) UITableViewCell *tourDepartureDateCell;

@property (nonatomic, strong) UITableViewCell *touristsCell;

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
        self.tourDepartureDateCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:true needArrow:false isSelected:false];
    }
    return _tourDepartureDateCell;
}

- (UITableViewCell *)touristsCell {
    if (!_touristsCell) {
        static NSString *reuseID = @"touristsCellReuseIdentifier";
        self.touristsCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        self.touristsCell.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:true needArrow:false isSelected:false];
    }
    return _touristsCell;
}

@end
