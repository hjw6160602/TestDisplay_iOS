//
//  RouteGnyDetailImageNameCell.m
//  Lvmm
//
//  Created by zhulihong on 16/8/17.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

#import "RouteCjyDetailImageNameCell.h"
#import "RouteCjyDetailImageTitleViewModel.h"
#import "UIColor+LVUtil.h"
#import "GroupedCellBgView.h"
#import "Masonry.h"


@interface RouteCjyDetailImageNameCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeftConstraint;

@end

@implementation RouteCjyDetailImageNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextBlack];
    self.titleDetailLabel.font = [UIFont systemFontOfSize:12];
    self.titleDetailLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray];
    self.titleDetailLabel.text = nil;
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray];
    self.detailLabel.text = nil;
}

- (void)assignViewModel:(id<RouteCjyDetailImageNameCellDelegate>)model {
    ViewModelConformsToProtocolAssign(model, RouteCjyDetailImageNameCellDelegate)
    
    self.backgroundView = [[GroupedCellBgView alloc] initWithFrame:CGRectZero withDataSourceCount:1 withIndex:0 isPlain:YES needArrow:false isSelected:false];

    if (model.image) {
        self.headerImageView.hidden = false;
        self.headerImageView.image = model.image;
        CGSize size = model.image.size;
        self.titleLabel.text = model.title;
        [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width);
            make.height.mas_equalTo(size.height);
        }];
        self.titleLabelLeftConstraint.constant = 10 + size.width + 5;
    } else {
        self.headerImageView.hidden = true;
        self.titleLabel.text = model.title;
        self.titleLabelLeftConstraint.constant = 10;
    }
    if ([model respondsToSelector:@selector(detailText)]) {
        self.detailLabel.text = model.detailText;
    } else {
        self.detailLabel.text = nil;
    }
    
    if ([model respondsToSelector:@selector(titleDetail)]) {
        self.titleDetailLabel.text = model.titleDetail;
    } else {
        self.titleDetailLabel.text = nil;
    }
    if ([model respondsToSelector:@selector(detailTextColor)]) {
        if (model.detailTextColor) {
            self.detailLabel.textColor = model.detailTextColor;
        } else {
            self.detailLabel.textColor = [UIColor lvColorWithHexadecimal:kColorTextLightGray];
        }
    }
}

@end
