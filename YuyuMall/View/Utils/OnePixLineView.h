//
//  OnePixLineView.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PixLinePosition)
{
    PixLineTop,
    PixLineBottom,
    PixLineLeft,
    PixLineRight
};

@interface OnePixLineView : UIView
@property(nonatomic,retain)UIColor *lineColor;

- (id)initWithFrame:(CGRect)frame position:(PixLinePosition)position;
@end
