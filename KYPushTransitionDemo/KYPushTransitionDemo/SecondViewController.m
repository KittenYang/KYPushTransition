//
//  SecondViewController.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/18/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
