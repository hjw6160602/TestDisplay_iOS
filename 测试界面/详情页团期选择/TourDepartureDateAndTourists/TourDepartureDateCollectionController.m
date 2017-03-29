//
//  TourDepartureDateCollectionController.m
//  测试界面
//
//  Created by 贺嘉炜 on 2017/3/29.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "TourDepartureDateCollectionController.h"
#import "TourDepartureDateCollectionCell.h"

@interface TourDepartureDateCollectionController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation TourDepartureDateCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(nonnull UICollectionViewLayout *)layout
                                    Products:(NSArray *)products{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.array = products;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[TourDepartureDateCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TourDepartureDateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.date = [self.array objectAtIndex:indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
