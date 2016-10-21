//
//  RootViewController.m
//  YuyuMall
//
//  Created by rock on 16/9/2.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  创建NavBar
 */
- (void)createNavBar{
    
}

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:_noDataView];
        }
    }];
}

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
    }
}


/**
 *  加载视图
 */
- (void)showLoadingAnimation{
    RTSpinKitView *spinner = [[RTSpinKitView alloc]initWithStyle:RTSpinKitViewStyleWave color:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]];
    [self.view addSubview:spinner];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];
    _spintView = spinner;
}


/**
 *  停止加载
 */
- (void)stopLoadingAnimation{
    [_spintView stopAnimating];
    [_spintView removeFromSuperview];
}

/**
 *  登陆
 */
- (void)goLogin{

}

/**
 *  初始化状态栏
 */
- (void)initStatusBar{

}

/**
 * 显示状态栏并设置标题
 */
- (void)showStatusBarWithTitle:(NSString *)title{

}

/**
 * 修改状态栏标题
 */
- (void)changeStatusBarTitle:(NSString *)title{

}

/**
 * 隐藏状态栏
 */
- (void)hiddenStatusBar{

}

@end
