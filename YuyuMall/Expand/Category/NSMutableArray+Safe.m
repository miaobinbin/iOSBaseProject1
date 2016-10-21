//
//  NSMutableArray+Safe.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (void)safeRemoveObjectAtIndex:(NSInteger)index
{
    if (index >= self.count)
        return;
    
    [self removeObjectAtIndex:index];
}

@end
