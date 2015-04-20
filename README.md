# KYPushTransition
一个3D翻转的转场动画，可以手势百分比控制。

![](demo.gif)

###Usage

以下代码全在第一个视图控制器中实现：

进入第一个控制器。在跳转之前，设置后一个控制器的代理，比如我用Segue的话，就在`-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender`里设置后一个控制器的代理为前一个控制器，并且让后一个控制器实现手势返回的交互：

```
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecondViewController *secVC = (SecondViewController *)segue.destinationViewController;
    secVC.transitioningDelegate = self;
    popInteractive = [KYPopInteractiveTransition new];
    [popInteractive addPopGesture:secVC];
}
```


然后分两种情况：

###1）如果只是一个VC present 到另一个 VC，那么你需要实现`UIViewControllerTransitioningDelegate`中的两个协议，分别对应`present`和`dismiss`,返回对应的动画:

```
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    KYPushTransition *flip = [KYPushTransition new];

    return flip;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    KYPopTransition *flip = [KYPopTransition new];
    return flip;
    
}
```

然后是手势交互的方法，比较常用的情况是返回上一个VC采用手势，所以这里只实现了dismiss的方法：

```
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return popInteractive.interacting ? popInteractive : nil;
    
}
```


###2）如果你是用UINavigationController控制两个VC，那么需要实现`UINavigationControllerDelegate`中的：
```
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        KYPushTransition *flip = [KYPushTransition new];
        return flip;
        
    }else if (operation == UINavigationControllerOperationPop){
        
        KYPopTransition *flip = [KYPopTransition new];
        return flip;
        
    }else{
        return nil;
    }
}
```

UINaviagtionController控制VC的情况下，`UINavigationControllerDelegate`也有相应的手势交互的协议方法：
```
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
        return popInteractive.interacting ? popInteractive : nil;

```


点击[博客介绍](http://kittenyang.com/3dfliptransition/)阅读详细实现细节

