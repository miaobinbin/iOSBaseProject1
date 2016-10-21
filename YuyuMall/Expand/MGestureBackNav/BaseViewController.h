//
//  BaseViewController.h
//  YuyuMall
//
//  Created by rock on 16/9/5.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)IBOutlet UIView *m_backGroundView;

@property(nonatomic,strong)NSMutableDictionary *baseParameters;

-(BOOL)isShowSlideBackNoticeWhenNeed;

-(void)viewWillBePopToDisappear;

-(BOOL)isUserGestureBack;

-(BOOL)isNeedBackToRoot;

@end
