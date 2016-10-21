//
//  MyPageControl.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//
#import "MyPageControl.h"

@implementation MyPageControl
@synthesize inactiveImage,activeImage,type,kSpacing;

- (id)initWithFrame:(CGRect)frame currentImageName:(NSString *)current commonImageName:(NSString *)common
{
    self= [super initWithFrame:frame];
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    activeImage= [UIImage imageNamed:current];
    inactiveImage= [UIImage imageNamed:common];
    kSpacing=5.0f;
    //hold住原来pagecontroll的subview
    usedToRetainOriginalSubview=[NSArray arrayWithArray:self.subviews];
    for (UIView *su in self.subviews) {
        [su removeFromSuperview];
    }
    self.contentMode=UIViewContentModeRedraw;
    return self;
}


- (void)updateDots
{
    
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot =[self.subviews objectAtIndex:i];
        
        if ([dot isKindOfClass:[UIImageView class]])
        {
            if (i == self.currentPage) {
                if ([dot respondsToSelector:@selector(setImage:)]) {
                    dot.image=activeImage;
                }
            } else {
                if ([dot respondsToSelector:@selector(setImage:)]) {
                    dot.image=inactiveImage;
                }
            }
            
            CGRect frame = dot.frame;
            frame.size.height = dot.image.size.height/3;
            frame.size.width = dot.image.size.width/3;
            dot.frame = frame;
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if (__gSystemVersion < 7.0) {
        [self updateDots];
    }
    [self setNeedsDisplay];
}
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    if (__gSystemVersion <7.0) {
        [self updateDots];
    }
    //    [self updateDots];
    [self setNeedsDisplay];
    
}
-(void)drawRect:(CGRect)iRect
{
    if (__gSystemVersion >= 7.0){//加个判断
        int i;
        CGRect rect;
        
        UIImage *image;
        iRect = self.bounds;
        
        if ( self.opaque) {
            [self.backgroundColor set];
            UIRectFill( iRect );
        }
        
        if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
        
        rect.size.height = activeImage.size.height/3;
        rect.size.width = self.numberOfPages * activeImage.size.width/3 + ( self.numberOfPages - 1 ) * kSpacing;
        rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
        rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
        rect.size.width = activeImage.size.width/3;
        
        for ( i = 0; i < self.numberOfPages; ++i ) {
            image = i == self.currentPage ? activeImage : inactiveImage;
            
            [image drawInRect: rect];
            
            rect.origin.x += activeImage.size.width/3 + kSpacing;
        }
    }else {
        
    }
    
}

@end
