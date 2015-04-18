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
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];

    
    fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    fromVC.view.layer.position  = CGPointMake(0, CGRectGetMidY(fromVC.view.bounds));
    fromVC.view.layer.transform  = [self setTransform3D];
    
    toVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    toVC.view.layer.position = CGPointMake(0, CGRectGetMidY(toVC.view.bounds));
    toVC.view.layer.transform = [self setTransform3D];
    
    CABasicAnimation *rotationAnim_from = [CABasicAnimation animationWithKeyPath:@"rotationY"];
    rotationAnim_from.duration = [self transitionDuration:transitionContext];
    rotationAnim_from.toValue = @(M_PI/2);
    rotationAnim_from.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim_from.delegate = self;
    [fromVC.view.layer addAnimation:rotationAnim_from forKey:@"pop_rotationAnim_from"];
    
    
    CABasicAnimation *rotationAnim_to = [CABasicAnimation animationWithKeyPath:@"rotationY"];
    rotationAnim_to.duration = [self transitionDuration:transitionContext];
    rotationAnim_to.fromValue = @(-M_PI/2);
    rotationAnim_to.toValue = @(0);
    rotationAnim_to.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim_to.delegate = self;
    [toVC.view.layer addAnimation:rotationAnim_to forKey:@"pop_rotationAnim_to"];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
}

-(CATransform3D)setTransform3D{
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = -0.002;
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
