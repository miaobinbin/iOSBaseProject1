//
//  NSObject+YuyuMall.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "NSObject+YuyuMall.h"
#import <objc/runtime.h>
static void *ModelCachedPropertyKeysKey = &ModelCachedPropertyKeysKey;

@implementation NSObject (YuyuMall)

+ (NSSet *)propertyKeys{
    NSSet *cachedKeys = objc_getAssociatedObject(self, ModelCachedPropertyKeysKey);
    if (cachedKeys){
        return cachedKeys;
    }
    NSMutableSet *keys = [NSMutableSet set];
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    
    for (int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        NSString *key = @(property_getName(property));
        [keys addObject:key];
    }
    objc_setAssociatedObject(self, ModelCachedPropertyKeysKey, keys, OBJC_ASSOCIATION_COPY);
    return keys;
}

@end
