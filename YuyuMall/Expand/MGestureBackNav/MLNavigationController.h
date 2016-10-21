//
//  MLNavigationController.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MLNavigationController : UINavigationController <UIGestureRecognizerDelegate>{
    
    BOOL canDragBack;//软件是否可以侧滑退出
    UIImageView *shadowImageView;
    __weak UIScrollView *myHorizontalScrollView;//横向的scrollView,用于某些界面有横向滑动的View时当到第一个view时才可以手势退出
    __weak UIScrollView *myVerticalScrollView;//竖向的scrollView,用于触发手势返回时禁用子页面的上下滑动
    CGPoint downPoint;
    /*0默认值，1侧滑，2上下滑*/
    int slideType;
    
    BOOL isNowViewNeedBackToRoot;//当前controller返回时是否需要返回到根conroller
    __weak BaseViewController *nowViewController;//当前显示的viewController,若当前Controller没有继承基类则为空
}

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;

@end
