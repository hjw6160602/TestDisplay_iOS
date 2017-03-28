//
//  ViewController.m
//  UICollectionView
//
//  Created by 贺嘉炜 on 2017/3/27.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CollectionViewController *collectionViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionViewController.collectionView];
}


- (CollectionViewController *)collectionViewController {
    if (!_collectionViewController) {
        
        CGFloat MARGIN = 10;
        CGFloat AspectRatio = 124.0 /147.0;
        CGFloat width = CGRectGetWidth(self.view.frame);
//        NSUInteger rows = ceilf(self.dataVM.guessYouLikeProductArr.count / 2);
//        CGFloat height = width * AspectRatio;
//        CGRect frame = CGRectMake(0, 0, width, height);
//        flowLayout.minimumLineSpacing = MARGIN;
//        flowLayout.minimumInteritemSpacing = MARGIN;
        CGFloat itemW = (width - 3 * MARGIN) / 2;
        CGFloat itemH = itemW * AspectRatio;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        //item之间的距离
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;

        self.collectionViewController = [[CollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
        
        self.collectionViewController.collectionView.contentInset = UIEdgeInsetsMake(MARGIN, MARGIN, MARGIN, MARGIN);
    }
    return _collectionViewController;
}


@end
