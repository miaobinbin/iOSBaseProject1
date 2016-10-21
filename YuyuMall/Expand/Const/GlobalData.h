//
//  GlobalData.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <Foundation/Foundation.h>

//全局单例 存放缓存的数据
@interface GlobalData : NSObject
// screen-height - 20.0f
extern float __gScreenHeight;
// screen-width
extern float __gScreenWidth;
//设备系统版本 7.0
extern float __gSystemVersion;

@end
