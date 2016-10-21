//
//  YYMLog.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

#define YYMLogVerbose(frmt, ...)  DDLogVerbose(frmt, ##__VA_ARGS__)
#define YYMLogDebug(frmt, ...)    DDLogDebug(frmt, ##__VA_ARGS__)
#define YYMLogInfo(frmt, ...)     DDLogInfo(frmt, ##__VA_ARGS__)
#define YYMLogWarn(frmt, ...)     DDLogWarn(frmt, ##__VA_ARGS__)
#define YYMLogError(frmt, ...)    DDLogError(frmt, ##__VA_ARGS__)

/**
 * 日志工具类，没有任何实现，只是在类被系统加载时初始化DDLog，完全嫁接DDLog的相关方法
 */
@interface YYMLog : NSObject

@end
