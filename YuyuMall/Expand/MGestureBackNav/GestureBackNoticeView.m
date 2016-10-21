//
//  GestureBackNoticeView.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "GestureBackNoticeView.h"

@implementation GestureBackNoticeView

-(void)dealloc{

}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *backGround=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gScreenHeight)];
        backGround.backgroundColor=[UIColor blackColor];
        backGround.alpha=0.5f;
        [self addSubview:backGround];
        
//        UIImageView *noticeIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, __gScreenHeight)];
//        noticeIamge.image=[UIImage imageNamed:@"tips_right"];
//        noticeIamge.contentMode = UIViewContentModeLeft;
//        [self addSubview:noticeIamge];
        
        isNoticeFinished=NO;
        
        //监测手势
        UIPanGestureRecognizer* recognizer;
        recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewPanGesture:)];
        [self addGestureRecognizer:recognizer];
        recognizer.delegate = self;
    }
    return self;
}


//滑动手势处理方法
-(void)handleViewPanGesture:(UIPanGestureRecognizer *)panGesture{
    CGFloat translation_y = [panGesture translationInView:self].y;
    CGFloat translation_x = [panGesture translationInView:self].x;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{//滑动开始
            slideType=0;
            downX=translation_x;
            downY=translation_y;
            isMoving=NO;
        }break;
        case UIGestureRecognizerStateChanged:{//滑动
            float disx=translation_x-downX;
            float absDisY=fabs(translation_y-downY);
            if(slideType==0&&disx>10&&disx>absDisY){//识别为滑动
                slideType=1;
                isMoving=YES;
                downX=translation_x;
                downY=translation_y;

            }else if(slideType==0&&absDisY>10&&absDisY>disx){
                slideType=2;
            }        }break;
        case UIGestureRecognizerStateEnded:{//滑动结束
            if(slideType==1){
                isMoving=NO;
                if (translation_x - downX > 50){
                    [UIView animateWithDuration:0.3 animations:^{
                        [self moveViewWithX:__gScreenWidth];
                    } completion:^(BOOL finished) {
                        isNoticeFinished=YES;
                        [self removeFromSuperview];
                    }];
                }else{
                    [UIView animateWithDuration:0.3 animations:^{
                        [self moveViewWithX:0];
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }break;
        case UIGestureRecognizerStateCancelled:
            if(slideType==1){
                isMoving=NO;
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    
                }];
            }
            break;
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }
    // it keeps move with touch
    if (isMoving&&slideType==1) {
        [self moveViewWithX:translation_x - downX];
    }
    
}



// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x{
    x = x>__gScreenWidth?__gScreenWidth:x;
    x = x<0?0:x;
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

@end
