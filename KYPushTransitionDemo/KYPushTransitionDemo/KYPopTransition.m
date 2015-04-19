//
//  KYPopTransition.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/19/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYPopTransition.h"

@interface KYPopTransition()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation KYPopTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{

    return 1.5f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    //改变View的锚点
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:toView];
    
    //让toView的截图旋转90度
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            //旋转fromView 90度
            toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
        }];
    } completion:^(BOOL finished) {
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.frame = initialFrame;
        [transitionContext completeTransition:YES];
    }];
    
}

//给传入的View改变锚点
-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    float xOffset = anchorPoint.x - 0.5;
    view.frame = CGRectOffset(view.frame, xOffset *view.frame.size.width, 0);
}




@end
