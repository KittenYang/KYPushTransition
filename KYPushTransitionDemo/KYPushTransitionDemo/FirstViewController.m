//
//  FirstViewController.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/18/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

//@property(nonatomic,strong)KYPushTransition *pushTransition;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Unwind Segue
-(IBAction)unwindSegue:(UIStoryboardSegue *)segue{
    
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    KYPushTransition *pushTransition = [KYPushTransition new];
    return pushTransition;
}
@end
