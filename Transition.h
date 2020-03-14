//
//  Transition.h
//  Transition
//
//  Created by whde on 16/4/11.
//  Copyright © 2016年 whde. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TransitionType) {
    POP,
    PUSH
};

@interface Transition : NSObject<UIViewControllerAnimatedTransitioning> {
    TransitionType type_;
}
- (instancetype)initWithTransitionType:(TransitionType)type;
@end
