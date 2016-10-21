//
//  CycleScrollView.h
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ETCycleScrollViewDelegate <NSObject>

@optional
//滑动到第index个view时调用
- (void)cycleScrollViewIndexChanged:(NSInteger)index;

//开始滑动
- (void)cycleScrollViewStartScroll:(NSInteger)currentPage;

-(void)cycleScrollViewChangePage:(NSInteger)currentPage withOtherPage:(NSInteger)otherPage changeValue:(float)value;
//滑动结束时调用
- (void)cycleScrollViewShowSubViewAtIndex:(NSInteger)currentPage lastPage:(NSInteger)lastPage firstShown:(BOOL)firstShown;

@end

@interface CycleScrollView : UIView<UIScrollViewDelegate>{
    NSMutableArray *roundArray;
    NSMutableArray *visibleArray;
    
    CGFloat height;
    CGFloat width;
    NSInteger currentPage;
    NSInteger lastPage;
    NSInteger startScrollPage;
    NSInteger numberOfPages;
    
    BOOL isAnimating;
    BOOL isScrolling;
    BOOL animateNoScroll;//animate:NO 滑动

}
@property(nonatomic, weak)id<ETCycleScrollViewDelegate> delegate;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic)NSInteger numberOfPages;
@property(nonatomic)NSInteger otherCurrentPage;
@property(nonatomic,assign) BOOL    isCycleScroll;
@property(nonatomic, strong) UIScrollView *myScrollView;
- (void)addView:(UIView *)view;//循环滑动
-(void)addViewToNoCycleScrollView:(UIView*)view;//不循环滑动
- (void)showDefaultIndex:(int)index;//必须调用，滑动到默认页

- (void)scrollIndexToVisible:(NSInteger)index animated:(BOOL)animated;
- (void)removeAllViews;

@end
