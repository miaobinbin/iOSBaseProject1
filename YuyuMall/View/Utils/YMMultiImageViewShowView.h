//
//  YMMultiImageViewShowView.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@protocol YMMultiImageViewShowViewDelegate <NSObject>

@end

@interface YMMultiImageViewShowView : UICollectionReusableView
@property(nonatomic,strong) CycleScrollView *adCycleScrollView;
@property(nonatomic,weak) UIViewController *referenceController;
@property(nonatomic,assign) BOOL enableShowBigImage;
@property(nonatomic,assign) BOOL isCanStatistics;
@property(nonatomic,weak) id<YMMultiImageViewShowViewDelegate> delegate;

-(void)setDataWithDataArray:(NSArray*)dataArray;

@end
