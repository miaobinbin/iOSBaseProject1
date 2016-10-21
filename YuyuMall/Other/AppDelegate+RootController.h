//
//  AppDelegate+RootController.h
//  YuyuMall
//
//  Created by rock on 16/9/2.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)

/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
- (void)setTabbarController;

/**
 *  window实例
 */
- (void)setAppWindows;

/**
 *  设置根视图
 */
- (void)setRootViewController;

@end
