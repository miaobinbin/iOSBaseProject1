//
//  NSDate+YuyuMall.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "NSDate+YuyuMall.h"

static NSDictionary *weakDayStringDic = nil;

@implementation NSDate (YuyuMall)
- (NSDate *)dateByAddingMonth:(NSInteger)months
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = months;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dateByAddingDay:(NSInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSString *)weekDayString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakDayStringDic = @{@1:@"周日",
                             @2:@"周一",
                             @3:@"周二",
                             @4:@"周三",
                             @5:@"周四",
                             @6:@"周五",
                             @7:@"周六"};
    });
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSWeekdayCalendarUnit
                                                                       fromDate:self];
    return weakDayStringDic[@(dateComponents.weekday)];
}

- (NSInteger)year
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit
                                                                       fromDate:self];
    return dateComponents.year;
    
}

- (NSInteger)month
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit
                                                                       fromDate:self];
    return dateComponents.month;
    
}

- (NSInteger)day
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit
                                                                       fromDate:self];
    return dateComponents.day;
    
}

- (NSInteger)hour {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps.hour;
}

- (NSInteger)minute {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps.minute;
}
@end
