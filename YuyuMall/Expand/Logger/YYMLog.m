//
//  YYMLog.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "YYMLog.h"

@implementation YYMLog

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelDebug];
        [DDLog addLogger:[DDASLLogger sharedInstance] withLevel:DDLogLevelInfo];
        [DDLog addLogger:[[DDFileLogger alloc] init] withLevel:DDLogLevelError];
    });
}

@end
