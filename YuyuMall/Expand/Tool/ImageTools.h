//
//  ETImageTools.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTools : NSObject

+ (UIImage*)thumbnailForFileWithData:(NSData*)imgData _thumW:(CGFloat)thumW;

+(UIImage *)fixOrientation:(UIImage *)aImage;

@end
