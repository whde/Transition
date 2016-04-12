//
//  CollectionViewController.h
//  Transition
//
//  Created by whde on 16/4/12.
//  Copyright © 2016年 whde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UINavigationControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;

@end
