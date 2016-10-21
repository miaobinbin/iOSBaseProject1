//
//  UIView+FrameAddition.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (FrameAddition)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end
