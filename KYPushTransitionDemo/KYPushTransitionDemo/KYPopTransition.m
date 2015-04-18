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

    return 0.7f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromView.layer.position  = CGPointMake(0, CGRectGetMidY(fromView.bounds));
    fromView.layer.transform  = [self setTransform3D];
    
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = CGPointMake(0, CGRectGetMidY(toView.bounds));
    toView.layer.transform = [self setTransform3D];
    
    CABasicAnimation *rotationAnim_from = [CABasicAnimation animationWithKeyPath:@"rotationY"];
    rotationAnim_from.duration = [self transitionDuration:transitionContext];
    rotationAnim_from.toValue = @(M_PI/2);
    rotationAnim_from.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim_from.delegate = self;
    [fromView.layer addAnimation:rotationAnim_from forKey:@"pop_rotationAnim_from"];
    
    
    CABasicAnimation *rotationAnim_to = [CABasicAnimation animationWithKeyPath:@"rotationY"];
    rotationAnim_to.duration = [self transitionDuration:transitionContext];
    rotationAnim_to.fromValue = @(-M_PI/2);
    rotationAnim_to.toValue = @(0);
    rotationAnim_to.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim_to.delegate = self;
    [toView.layer addAnimation:rotationAnim_to forKey:@"pop_rotationAnim_to"];
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
}

-(CATransform3D)setTransform3D{
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = 2.5/-2000;
    return transfrom;
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //通知transition 已完成
//    [self.transitionContext completeTransition:YES];
    
}


@end
