//
//  HudUtils.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.
//


#import "HudUtils.h"

@implementation HudUtils

+ (MBProgressHUD *)hudWithLabel:(NSString *)text inView:(UIView *)inView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    if (text) {
        hud.labelText = text;
    } else {
        hud.labelText = @"加载中...";
    }
	
	hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
	
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    } else {
        [hud hide:YES afterDelay:3];
    }
    return hud;
}

+ (MBProgressHUD *)hudWithLabel:(NSString *)text customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
	
    if (customView) {
        hud.customView = customView;
    } else {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_mark"]];
    }
    
	hud.labelText = text;
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
	hud.removeFromSuperViewOnHide = YES;
    
    if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    }
	return hud;
}

+ (MBProgressHUD *)hudWithLabel:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [self hudWithLabel:text customView:customView inView:inView delay:delay];
    hud.detailsLabelText = detailText;
    return hud;
}

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
+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)inView delay:(NSInteger)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (text) {
        hud.labelText = text;
    } else {
        hud.labelText = @"...";
    }
    hud.detailsLabelText = detailText;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    } else {
        [hud hide:YES afterDelay:3];
    }
    return hud;
}

@end
