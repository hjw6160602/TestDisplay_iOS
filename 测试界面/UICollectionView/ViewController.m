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
    
    [self.navigationController pushViewController:self.collectionViewController animated:YES];
}


- (CollectionViewController *)collectionViewController {
    if (!_collectionViewController) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //item之间的距离
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        
        self.collectionViewController = [[CollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
    }
    return _collectionViewController;
}


@end
