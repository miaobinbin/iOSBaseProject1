//
//  BaseViewController.m
//  YuyuMall
//
//  Created by rock on 16/9/5.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize m_backGroundView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_backGroundView.frame = CGRectMake(0, 0, __gScreenWidth, __gScreenHeight + APP_YOFFSET);
    m_backGroundView.backgroundColor = [UIColor clearColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当需要显示侧滑返回提示时 该controller是否显示，默认显示，登陆页面不显示
-(BOOL)isShowSlideBackNoticeWhenNeed{
    return NO;
}

//当controller被pop出来时均会触发该方法
-(void)viewWillBePopToDisappear{
    
}

//标识该controller是否使用手势退出功能,默认YES
-(BOOL)isUserGestureBack{
    return YES;
}

//标记该controller是否需要直接返回到根controller
-(BOOL)isNeedBackToRoot{
    return NO;
}

- (BOOL)shouldOpenViewControllerWithURL:(NSURL *)aUrl{
    return YES;
}

- (void)openedFromViewControllerWithURL:(NSURL *)aUrl{
    
}


@end
