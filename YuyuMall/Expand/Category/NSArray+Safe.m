//
//  NSArray+Safe.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
        return nil;
    
    return [self objectAtIndex:index];
}

@end
