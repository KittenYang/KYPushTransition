//
//  KYPushTransition.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/18/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYPushTransition.h"

@implementation KYPushTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.7f;
}



- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromView.layer.position  = CGPointMake(0, CGRectGetMidY(fromView.bounds));
    fromView.layer.transform  = [self setTransform3D];
    
    
}



-(CATransform3D)setTransform3D{
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = 2.5/-2000;
    return transfrom;
}
@end
