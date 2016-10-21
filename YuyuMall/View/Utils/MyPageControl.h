//
//  MyPageControl.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface MyPageControl : UIPageControl{
    UIImage* activeImage;
    UIImage* inactiveImage;
    
    NSArray *usedToRetainOriginalSubview;
    float kSpacing;
}
@property(nonatomic,strong) UIImage *activeImage,*inactiveImage;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)float kSpacing;

- (id)initWithFrame:(CGRect)frame currentImageName:(NSString *)current commonImageName:(NSString *)common;
-(void)updateDots;
-(void)setCurrentPage:(NSInteger)page;
@end
