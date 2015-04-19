//
//  FirstViewController.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/18/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "KYPushTransition.h"
#import "KYPopTransition.h"

#import "CEFlipAnimationController.h"

@interface FirstViewController ()

//@property(nonatomic,strong)KYPushTransition *pushTransition;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    SecondViewController *secVC = (SecondViewController *)segue.destinationViewController;
//    secVC.transitioningDelegate = self;
//    
//    [super prepareForSegue:segue sender:sender];
//    
//}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        KYPushTransition *flip = [KYPushTransition new];
//        CEFlipAnimationController *flip = [CEFlipAnimationController new];
//        flip.reverse = YES;
        return flip;
    }else if (operation == UINavigationControllerOperationPop){
        KYPopTransition *flip = [KYPopTransition new];
//        CEFlipAnimationController *flip = [CEFlipAnimationController new];
//        flip.reverse = NO;
        return nil;
    }else{
        return nil;
    }
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    KYPushTransition *flip = [KYPushTransition new];
//    CEFlipAnimationController *flip = [CEFlipAnimationController new];
//    flip.reverse = YES;
    return flip;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
KYPopTransition *flip = [KYPopTransition new];
//    CEFlipAnimationController *flip = [CEFlipAnimationController new];
//    flip.reverse = NO;
    return nil;
    
}



@end
