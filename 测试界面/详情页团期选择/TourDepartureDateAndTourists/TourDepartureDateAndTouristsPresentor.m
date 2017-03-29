//
//  TourDepartureDateAndTouristsPresentor.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateAndTouristsPresentor.h"
#import "RouteCjyDetailBaseViewModel.h"
#import "BaseRouteCjyDetailCell.h"

@interface TourDepartureDateAndTouristsPresentor()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) BaseRouteCjyDetailCell *titleCell;

@end

@implementation TourDepartureDateAndTouristsPresentor

+ (instancetype)presentorWithTableView:(UITableView *)tableView {
    TourDepartureDateAndTouristsPresentor *presentor = [[TourDepartureDateAndTouristsPresentor alloc] init];
    presentor.tableView = tableView;
    return presentor;
}

#pragma mark - Getter
- (NSArray *)viewModels {
    
    NSMutableArray *sectionTourDepartureDateAndTourists = [NSMutableArray array];
    RouteCjyDetailBaseViewModel *title = [[RouteCjyDetailBaseViewModel alloc] initWithCell:self.titleCell cellHeight:44];
    
    [sectionTourDepartureDateAndTourists addObject:title];
    
//        [sectionsGuessYouLike addObject:[[RouteCjyDetailImageTitleViewModel alloc] initWithImage:[UIImage imageNamed:@"guessYouLike" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] title:@"猜你喜欢" detailText:@"" arrow:NO]];
//        
//        [sectionsGuessYouLike addObject:[[RouteCjyDetailBaseViewModel alloc] initWithCell:self.contentCell cellHeight:CGRectGetHeight(self.guessYouLikeView.frame)]];
    
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
