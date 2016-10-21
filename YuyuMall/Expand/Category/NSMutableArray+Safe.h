//
//  NSMutableArray+Safe.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright (c) 2016 YuyuMall.inc. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

- (void)safeRemoveObjectAtIndex:(NSInteger)index;

@end
