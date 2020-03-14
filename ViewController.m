//
//  ViewController.m
//  Transition
//
//  Created by whde on 16/4/11.
//  Copyright © 2016年 whde. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "ViewCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate> {
    NSArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"列表"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(151, 151);
    layout.minimumInteritemSpacing = 6;
    layout.minimumLineSpacing = 6;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    [_collectionView registerClass:[ViewCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 6, 0, 6);
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    self.title = @"列表";
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = array[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndexPath = indexPath;
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
