//
//  NSDate+YuyuMall.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YuyuMall)

- (NSDate *)dateByAddingMonth:(NSInteger)months;

- (NSString *)weekDayString;

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

- (NSDate *)dateByAddingDay:(NSInteger)days;

- (NSInteger)hour;

- (NSInteger)minute;

@end
