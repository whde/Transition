//
//  Transition.m
//  Transition
//
//  Created by whde on 16/4/11.
//  Copyright © 2016年 whde. All rights reserved.
//

#import "Transition.h"
#import "CollectionViewController.h"
#import "DetailViewController.h"
@implementation Transition
- (instancetype)initWithTransitionType:(TransitionType)type {
    self = [super init];
    type_ = type;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (type_ == PUSH) {
        CollectionViewController *fromVC = (CollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        DetailViewController *toVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //拿到当前点击的cell的imageView
        UICollectionViewCell *cell = [fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
        UIView *containerView = [transitionContext containerView];
        //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
        UIView *tempView = [cell.contentView snapshotViewAfterScreenUpdates:NO];
        tempView.frame = [cell.contentView convertRect:cell.contentView.bounds toView: containerView];
        //设置动画前的各个控件的状态
        cell.contentView.hidden = YES;
        toVC.view.alpha = 0;
        toVC.imageView.hidden = YES;
        //tempView 添加到containerView中，要保证在最前方，所以后添加
        [containerView addSubview:toVC.view];
        [containerView addSubview:tempView];
        //开始做动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
            tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            tempView.hidden = YES;
            toVC.imageView.hidden = NO;
            //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
            [transitionContext completeTransition:YES];
        }];
    } else {
        DetailViewController *fromVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        CollectionViewController *toVC = (CollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UICollectionViewCell *cell = [toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
        UIView *containerView = [transitionContext containerView];
        //这里的lastView就是push时候初始化的那个tempView
        UIView *tempView = containerView.subviews.lastObject;
        //设置初始状态
        cell.contentView.hidden = YES;
        fromVC.imageView.hidden = YES;
        tempView.hidden = NO;
        [containerView insertSubview:toVC.view atIndex:0];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
            tempView.frame = [cell.contentView convertRect:cell.contentView.bounds toView:containerView];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            //由于加入了手势必须判断
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
                //失败了隐藏tempView，显示fromVC.imageView
                tempView.hidden = YES;
                fromVC.imageView.hidden = NO;
            }else{//手势成功，cell的imageView也要显示出来
                //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
                cell.contentView.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }
}

@end
