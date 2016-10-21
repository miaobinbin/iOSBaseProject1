//
//  HudUtils.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HudUtils : NSObject

+ (MBProgressHUD *)hudWithLabel:(NSString *)text inView:(UIView *)inView;
+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text inView:(UIView *)inView delay:(NSInteger)delay;
+ (MBProgressHUD *)hudWithLabel:(NSString *)text customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay;
+ (MBProgressHUD *)hudWithLabel:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay;
/*!
 *  @author linfeng, 15-06-11 09:06:32
 *
 *  @brief  展示仅有文字 和 详细文字 的hud框
 *
 *  @param text
 *  @param detailText
 *  @param inView
 *  @param delay
 *
 *  @return
 */
+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)inView delay:(NSInteger)delay;

@end
