//
//  RootViewController.h
//  YuyuMall
//
//  Created by rock on 16/9/2.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpinKit/RTSpinKitView.h>

@interface RootViewController : UIViewController{
    RTSpinKitView *_spintView;
}

/**
 *  是否显示tabbar
 */
@property (nonatomic,assign)Boolean isShowTabbar;

/**
 *  无数据页面
 */
@property (nonatomic,strong) UIImageView* noDataView;

/**
 *  创建NavBar
 */
- (void)createNavBar;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;


/**
 *  加载视图
 */
- (void)showLoadingAnimation;


/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  登陆
 */
- (void)goLogin;

/**
 *  初始化状态栏
 */
- (void)initStatusBar;

/**
 * 显示状态栏并设置标题
 */
- (void)showStatusBarWithTitle:(NSString *)title;

/**
 * 修改状态栏标题
 */
- (void)changeStatusBarTitle:(NSString *)title;

/**
 * 隐藏状态栏
 */
- (void)hiddenStatusBar;

@end
