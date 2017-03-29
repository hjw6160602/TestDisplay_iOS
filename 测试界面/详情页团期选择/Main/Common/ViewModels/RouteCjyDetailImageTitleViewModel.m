//
//  RouteGnyDetailImageTitleViewModel.m
//  Lvmm
//
//  Created by zhulihong on 16/8/17.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "RouteCjyDetailImageTitleViewModel.h"

@interface RouteCjyDetailImageTitleViewModel ()

@end

@implementation RouteCjyDetailImageTitleViewModel

- (id)initWithImage:(UIImage *)image title:(NSString *)title detailText:(NSString *)detailText arrow:(BOOL)arrow {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.cellIdentifer = @"RouteCjyDetailImageNameCell";
        self.cellHeight = [RouteCjyDetailImageNameCell heightForViewModel:self];
        self.detailText = detailText;
        self.arrow = arrow;
    }
    
    return self;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath delegate:(id)delegate {
    RouteCjyDetailImageNameCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifer];
    cell.arrow = self.arrow;
    [cell assignViewModel:self];
    if (self.cellBackgroudView) {
        cell.backgroundView = self.cellBackgroudView;
    }
    
    return cell;
}

@end
