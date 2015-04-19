//
//  KYPushTransition.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/18/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#import "KYPushTransition.h"

@interface KYPushTransition()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation KYPushTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.5f;
}



- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    //把toView加到containerView上
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];//?
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:fromView];
    
    //增加阴影
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = fromView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer insertSublayer:gradient atIndex:1];
    shadow.alpha = 0.0;
    
    [fromView addSubview:shadow];
    
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            //旋转fromView 90度
            fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
            shadow.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.frame = initialFrame;
        fromView.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
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






