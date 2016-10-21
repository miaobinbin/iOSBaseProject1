//
//  CycleScrollView.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView

@synthesize delegate;
@synthesize currentPage, numberOfPages,isCycleScroll;
@synthesize myScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        myScrollView = [[UIScrollView alloc] init];
        width = frame.size.width;
        height = frame.size.height;
        myScrollView.frame = CGRectMake(0, 0, width, height);
        myScrollView.scrollEnabled = YES;
        myScrollView.pagingEnabled = YES;
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        myScrollView.delegate = self;
        myScrollView.clipsToBounds = NO;
        myScrollView.scrollsToTop = NO;
        [self addSubview:myScrollView];
        
        roundArray = [[NSMutableArray alloc] init];
        visibleArray = [[NSMutableArray alloc] init];
        
        isCycleScroll = YES;
        currentPage = 0;
        lastPage=0;
        _otherCurrentPage = 0;
        startScrollPage = -1;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    width = frame.size.width;
    height = frame.size.height;
    myScrollView.frame = CGRectMake(0, 0, width, height);
}


-(void)addViewToNoCycleScrollView:(UIView*)view{
     isCycleScroll = NO;
     if (view&&[view isKindOfClass:[UIView class]]) {
         [roundArray addObject:view];
         myScrollView.contentSize = CGSizeMake(width * roundArray.count, height);
         view.frame = CGRectMake((roundArray.count - 1) * width, 0, width, height);
         [myScrollView addSubview:view];
     }
}
//增加subview
- (void)addView:(UIView *)view
{
    isCycleScroll = YES;
    if (view&&[view isKindOfClass:[UIView class]]) {
        [myScrollView addSubview:view];
        [roundArray addObject:view];
        numberOfPages = roundArray.count;
        
        if (roundArray.count==1) {
            view.frame = CGRectMake(0, 0, width, height);
            myScrollView.contentSize = CGSizeMake(width, height);
        }else{
            view.frame = CGRectMake(roundArray.count * width, 0, width, height);
            
            if (roundArray.count>1) {
                myScrollView.contentSize = CGSizeMake(width * (roundArray.count+2), height);
            }
            
            if (roundArray.count==2) {
                UIView *firstView = [roundArray objectAtIndex:0];
                firstView.frame = CGRectMake(width, 0, width, height);
                animateNoScroll = YES;
                [self scrollIndexToVisible:0 animated:NO];
            }
        }
    }
}

- (void)showDefaultIndex:(int)index{
    if (index!=0) {
        [self scrollIndexToVisible:index animated:NO];
    }
    currentPage = index;
    [self showSubView];
}

#pragma mark uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isCycleScroll) {
        if (animateNoScroll) {
            animateNoScroll = NO;
            return;
        }
        if (!isScrolling) {
            isScrolling = YES;
            if (startScrollPage != -1) {
                startScrollPage = currentPage;
            }
            
            if ([delegate respondsToSelector:@selector(cycleScrollViewStartScroll:)]) {
                [delegate cycleScrollViewStartScroll:currentPage];
            }
        }
        
        if (roundArray.count>1) {
            NSInteger page=floor((scrollView.contentOffset.x - scrollView.frame.size.width/2) / __gScreenWidth) + 1;
            
            if (page==0) {
                page = roundArray.count-1;
            }else if (page>roundArray.count) {
                page = 0;
            }else{
                page--;
            }
            if (page!=currentPage&&!isAnimating) {
                lastPage = currentPage;
                currentPage = page;
                [self indexChanged];
            }
            
            float offsetX = myScrollView.contentOffset.x;
            if (offsetX<0){
                UIView *lastView = [roundArray lastObject];
                lastView.frame = CGRectMake(roundArray.count*width, 0, width, height);
                float x = width*roundArray.count + offsetX;
                myScrollView.contentOffset = CGPointMake(x, 0);
            }
            else if (offsetX<width) {
                UIView *lastView = [roundArray lastObject];
                lastView.frame = CGRectMake(0, 0, width, self.frame.size.height);
            }
            else if(offsetX>width*(roundArray.count+1)){
                UIView *firstView = [roundArray firstObject];
                firstView.frame = CGRectMake(width, 0, width, height);
                float x = width + (offsetX -width*(roundArray.count+1));
                myScrollView.contentOffset = CGPointMake(x, 0);
            }
            else if (offsetX>width*roundArray.count){
                UIView *firstView = [roundArray firstObject];
                firstView.frame = CGRectMake(width*(roundArray.count+1), 0, width, height);
            }else{
                UIView *firstView = [roundArray firstObject];
                firstView.frame = CGRectMake(width, 0, width, height);
            }
            
            if (offsetX>0&&offsetX<width*2) {
                UIView *firstView = [roundArray firstObject];
                if (firstView.frame.origin.x!=width) {
                    firstView.frame = CGRectMake(width, 0, width, height);
                }
            }
            if (offsetX>width*(roundArray.count-1)&&offsetX<width*(roundArray.count+1)) {
                UIView *lastView = [roundArray lastObject];
                if (lastView.frame.origin.x!=roundArray.count*width) {
                    lastView.frame = CGRectMake(roundArray.count*width, 0, width, height);
                }
            }
        }
 
    }else{
       NSInteger page=floor((scrollView.contentOffset.x - scrollView.frame.size.width * 0.5) / width) + 1;
        
        if (page != currentPage) {
            currentPage = page;
            if ([delegate respondsToSelector:@selector(cycleScrollViewIndexChanged:)]) {
                [delegate cycleScrollViewIndexChanged:currentPage];
            }
        }
        
        if(scrollView.contentOffset.x <= 0){
            _otherCurrentPage = 0;
            if ([delegate respondsToSelector:@selector(cycleScrollViewChangePage:withOtherPage:changeValue:)]) {
                [delegate cycleScrollViewChangePage:_otherCurrentPage withOtherPage:_otherCurrentPage changeValue:0];
            }
            return;
        }
        
        if(scrollView.contentOffset.x >= (roundArray.count - 1) * width){
            _otherCurrentPage = roundArray.count - 1;
            if ([delegate respondsToSelector:@selector(cycleScrollViewChangePage:withOtherPage:changeValue:)]) {
                [delegate cycleScrollViewChangePage:_otherCurrentPage withOtherPage:_otherCurrentPage changeValue:0];
            }
            return;
        }
        
        float value = scrollView.contentOffset.x / width;
        NSInteger otherPage = _otherCurrentPage;
        if (scrollView.contentOffset.x > _otherCurrentPage * width) {
            otherPage = _otherCurrentPage + 1;
        }else if (scrollView.contentOffset.x < _otherCurrentPage * width) {
            otherPage = _otherCurrentPage - 1;
        }
        value = fabsf(value - (int)value);
        if (value == 0) {
            _otherCurrentPage = otherPage;
        }else{
           NSInteger page1 = floor((scrollView.contentOffset.x - scrollView.frame.size.width) / width) + 1;
            if (page1 != _otherCurrentPage && page1 != otherPage) {
                _otherCurrentPage = page1;
            }
        }
        if ([delegate respondsToSelector:@selector(cycleScrollViewChangePage:withOtherPage:changeValue:)]) {
            [delegate cycleScrollViewChangePage:_otherCurrentPage withOtherPage:otherPage changeValue:value];
        }
        NSLog(@"_otherCurrentPage:%ld,otherPage:%ld,value:%f",_otherCurrentPage,otherPage,value);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (isCycleScroll) {
        if (!decelerate) {
            [self scrollViewDidEndDecelerating:scrollView];
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(isCycleScroll){
        isScrolling = NO;
        
        NSInteger page=floor((scrollView.contentOffset.x - scrollView.frame.size.width/2) / __gScreenWidth) + 1;
        if (page==0) {
            page = roundArray.count-1;
        }else if (page>roundArray.count) {
            page = 0;
        }else{
            page--;
        }
        currentPage = page;
        
        [self showSubView];
    }
}

//显示subview内容
- (void)showSubView{
    if (startScrollPage!=currentPage) {
        if (startScrollPage < 0) {
            startScrollPage = 0;
        }
        [self indexChanged];
        
        BOOL isFirstShow = YES;
        if ([visibleArray containsObject:[NSString stringWithFormat:@"%ld", (long)currentPage]]) {
            isFirstShow = NO;
        }else{
            [visibleArray addObject:[NSString stringWithFormat:@"%ld", (long)currentPage]];
        }
        
        if (currentPage>=0&&currentPage<roundArray.count&&startScrollPage>=0&&startScrollPage<roundArray.count) {
            if ([delegate respondsToSelector:@selector(cycleScrollViewShowSubViewAtIndex:lastPage:firstShown:)]) {
                [delegate cycleScrollViewShowSubViewAtIndex:currentPage lastPage:startScrollPage firstShown:isFirstShow];
            }
        }
        startScrollPage = currentPage;
    }
}

//显示的view改变
- (void)indexChanged{
    //    NSLog(@"pages:%d,%d",lastPage,currentPage);
    if ([delegate respondsToSelector:@selector(cycleScrollViewIndexChanged:)]) {
        if (lastPage!=currentPage) {
            if ([delegate respondsToSelector:@selector(cycleScrollViewIndexChanged:)]) {
                [delegate cycleScrollViewIndexChanged:currentPage];
            }
        }
        lastPage = currentPage;
    }
}

//remove所有subview
- (void)removeAllViews
{
    for (UIView *view in roundArray) {
        [view removeFromSuperview];
    }
    currentPage = 0;
    lastPage=0;
    _otherCurrentPage = 0;
    startScrollPage = -1;
    [roundArray removeAllObjects];
    [visibleArray removeAllObjects];
    myScrollView.contentSize = CGSizeMake(0, 0);
}

//显示第index个view
- (void)scrollIndexToVisible:(NSInteger)index animated:(BOOL)animated
{
    if (isCycleScroll) {
        isScrolling=NO;
        lastPage = currentPage;
        
        if (index<roundArray.count) {
            
            float x = width*index;
            if (roundArray.count>1) {
                x = width*(index+1);
            }
            if (animated) {
                isAnimating = YES;
                [self performSelector:@selector(setAnimated) withObject:nil afterDelay:0.3];
            }else{
                currentPage = index;
                [self indexChanged];
                animateNoScroll = YES;
            }
            [myScrollView scrollRectToVisible:CGRectMake(x, 0, width, height) animated:animated];
        }
    }else{
        [myScrollView scrollRectToVisible:CGRectMake(index * width, 0, width, height) animated:animated];
    }
    
}

- (void)setAnimated{
    isAnimating = NO;
    //调用scrollRectToVisible方法滑动结束后，不会调用scrollViewDidEndDecelerating
    [self scrollViewDidEndDecelerating:myScrollView];
}

@end
