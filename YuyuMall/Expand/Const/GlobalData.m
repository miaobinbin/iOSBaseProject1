//
//  GlobalData.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "GlobalData.h"
float __gScreenHeight = 0;

float __gScreenWidth = 0;

float __gSystemVersion = 7.0;

@implementation GlobalData

+ (GlobalData*)shareInstance{
    static GlobalData * globalData = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        globalData = [[GlobalData alloc] init];
    });
    return globalData;
}

@end
