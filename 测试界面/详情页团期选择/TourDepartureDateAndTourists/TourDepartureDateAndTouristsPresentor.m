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

@interface TourDepartureDateAndTouristsPresentor()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) BaseRouteCjyDetailCell *titleCell;

@end

static CGFloat const FOOT_HEIGHT = 10;

@implementation TourDepartureDateAndTouristsPresentor

+ (instancetype)presentorWithTableView:(UITableView *)tableView {
    TourDepartureDateAndTouristsPresentor *presentor = [[TourDepartureDateAndTouristsPresentor alloc] init];
    presentor.tableView = tableView;
    return presentor;
}

#pragma mark - Getter
- (NSArray *)viewModels {
    
    NSMutableArray *sectionTourDepartureDateAndTourists = [NSMutableArray array];

    RouteCjyDetailImageTitleViewModel *model = [[RouteCjyDetailImageTitleViewModel alloc] initWithImage:nil title:@"选择出游人数和日期" detailText:@"更改" arrow:YES];
    [sectionTourDepartureDateAndTourists addObject:model];
    
    [sectionTourDepartureDateAndTourists addObject:[[RouteCjyDetailBaseViewModel alloc] initClearSectionCellHeight:FOOT_HEIGHT]];
    
    return [sectionTourDepartureDateAndTourists copy];
}

- (BaseRouteCjyDetailCell *)titleCell {
    if (!_titleCell) {
        static NSString *reuseID = @"guessYouLikeContentCellIdentifier";
        self.titleCell = [[BaseRouteCjyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return _titleCell;
}


@end
