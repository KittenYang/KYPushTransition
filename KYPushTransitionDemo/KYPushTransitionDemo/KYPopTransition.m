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
    
    /*
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
     */
    //把toView加到containerView上
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

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
    
    //分别给fromVC和toVC创建一张截图
//    UIView *toViewSnapshots = [self createSnapshots:toView afterScreenUpdates:YES];
//    UIView *fromViewSnapshots = [self createSnapshots:fromView afterScreenUpdates:NO];//?
    
    //改变View的锚点
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:toView];
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
    
    [toView addSubview:shadow];
    
    
    
    
    //让toView的截图旋转90度
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            //旋转fromView 90度
            toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
            shadow.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
        [self removeOtherViews:toView];
    }];
    
}

//移除除了传入View之外的所有视图
- (void)removeOtherViews:(UIView*)viewToKeep {
    UIView* containerView = viewToKeep.superview;
    for (UIView* view in containerView.subviews) {
        if (view != viewToKeep) {
            [view removeFromSuperview];
        }
    }
}

//给传入的view创建的截图
- (UIView*)createSnapshots:(UIView*)view afterScreenUpdates:(BOOL) afterUpdates{
    UIView *contView = view.superview;
    
    //创建视图
    CGRect snapshotRegion = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    UIView *leftHandView = [view resizableSnapshotViewFromRect:snapshotRegion  afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = snapshotRegion;
    [contView addSubview:leftHandView];
    
    
    [contView sendSubviewToBack:view];//?
    
    return leftHandView;
    
}


//给传入的View改变锚点
-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    float xOffset = anchorPoint.x - 0.5;
    view.frame = CGRectOffset(view.frame, xOffset *view.frame.size.width, 0);
}




@end
