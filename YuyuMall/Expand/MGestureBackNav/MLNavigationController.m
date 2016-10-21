//
//  MLNavigationController.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import "MLNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface MLNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
    __weak UIView *preSuperView;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation MLNavigationController
@synthesize canDragBack;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        canDragBack = YES;
    }
    return self;
}

- (void)dealloc{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    nowViewController=nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(paningGestureReceive:)];
     recognizer.delegate = self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:(BOOL)animated];
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count>0){
        //        [self performSelectorOnMainThread:@selector(captureTheController:) withObject:[self.viewControllers lastObject] waitUntilDone:NO];
        //        [self captureTheController:[self.viewControllers lastObject]];
    }
    [super pushViewController:viewController animated:animated];
    [self readNowViewControllerProperty];
}

-(UIViewController *)getPreViewController{
    UIViewController *preController = nil;
    if (isNowViewNeedBackToRoot) {
        preController = [self.viewControllers objectAtIndex:0];
    } else {
        preController = [self.viewControllers objectAtIndex:self.viewControllers.count-2];
    }
    preSuperView = preController.view.superview;
    return preController;
    
}

//override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if(nowViewController!=nil){
        [nowViewController viewWillBePopToDisappear];
    }
    UIViewController *uc=[super popViewControllerAnimated:animated];
    [self readNowViewControllerProperty];
    return uc;
}
-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    if(nowViewController!=nil){
        [nowViewController viewWillBePopToDisappear];
    }
    NSArray *na=[super popToRootViewControllerAnimated:animated];
    [self readNowViewControllerProperty];
    return na;
}
-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(nowViewController!=nil){
        [nowViewController viewWillBePopToDisappear];
    }
    NSArray *na=[super popToViewController:viewController animated:animated];
    [self readNowViewControllerProperty];
    return na;
}
/*读取当前view的一些属性，如是否使用侧滑返回、返回时是否返回到根视图*/
-(void)readNowViewControllerProperty{
    myHorizontalScrollView=nil;
    myVerticalScrollView=nil;
    
    isNowViewNeedBackToRoot=NO;
    nowViewController=nil;
    NSInteger controllersCount=self.viewControllers.count;
    if(controllersCount>0){
        UIViewController *con=[self.viewControllers objectAtIndex:(controllersCount-1)];
        if([con isKindOfClass:[BaseViewController class]]){
            BaseViewController *bcon=(BaseViewController *)con;
            isNowViewNeedBackToRoot=[bcon isNeedBackToRoot];
            nowViewController=bcon;
        }
    }
}

#pragma mark - Utility Methods -

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x{
    x = x>__gScreenWidth?__gScreenWidth:x;
    x = x<0?0:x;
    UIView *topView=self.view;
    CGRect frame = topView.frame;
    frame.origin.x = x;
    topView.frame = frame;
    
//    float scale = (x/6400)+0.95;
//    float alpha = 0.4 - (x/800);
//    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
//    blackMask.alpha = alpha;
    
    float alpha = 0.4 - (x/800);
    blackMask.alpha = alpha;
    frame=lastScreenShotView.frame;
    frame.origin.x=-(__gScreenWidth)/4+x*0.25f;
    lastScreenShotView.frame=frame;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count <= 1 || !canDragBack){
        return NO;
    }else if(myHorizontalScrollView!=nil&&myHorizontalScrollView.contentOffset.x>0){
        return NO;
    }else {
        BaseViewController *lastcon = [self.viewControllers lastObject];
        if ([lastcon isKindOfClass:[BaseViewController class]]) {
            BOOL isNowViewCanUseGestureBack = [lastcon isUserGestureBack];
            if (isNowViewCanUseGestureBack) {
                return YES;
            } else {
                return NO;
            }
        }
        return YES;
    }
    return YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]){
        UIScrollView *view=(UIScrollView *)otherGestureRecognizer.view;
        if(myHorizontalScrollView!=view&&view.contentSize.width>__gScreenWidth){
            myHorizontalScrollView=view;
            if(myHorizontalScrollView.contentOffset.x>0){
                return NO;
            }
        }else if(myVerticalScrollView==nil&&view.contentSize.width<=__gScreenWidth){
            myVerticalScrollView=view;
        }
        return YES;
    }
    return NO;
}
#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer{
    // If the viewControllers has only one vc or disable the interaction, then return.
    // we get the touch position by the window's coordinate
    CGPoint touchPoint =[recoginzer translationInView:KEY_WINDOW];
    if(recoginzer.state == UIGestureRecognizerStateBegan){
        downPoint=touchPoint;
        _isMoving=NO;
        slideType=0;
    }else if(slideType==0&&recoginzer.state == UIGestureRecognizerStateChanged){
        float disx=touchPoint.x-downPoint.x;
        float absDisY=abs(touchPoint.y-downPoint.y);
        if(slideType==0&&disx>10&&disx>absDisY){//识别为滑动
            downPoint=touchPoint;
            slideType=1;
            _isMoving=YES;
            if(myHorizontalScrollView!=nil){myHorizontalScrollView.scrollEnabled=NO;}
            if(myVerticalScrollView!=nil){myVerticalScrollView.scrollEnabled=NO;}
            ////////初始化滑动退出的底部截图view/////////
            if (!self.backgroundView) {
                UIView *topView=self.view;
                
                CGRect frame = topView.frame;
                self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                [topView.superview insertSubview:self.backgroundView belowSubview:topView];
                float y=20;
                if(__gSystemVersion>=7.0){
                    y=0;
                }
                lastScreenShotView=[[UIImageView alloc]initWithFrame:CGRectMake(0, y, topView.frame.size.width, topView.frame.size.height-y)];
                [self.backgroundView addSubview:lastScreenShotView];
                
                blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                blackMask.backgroundColor = [UIColor blackColor];
                [self.backgroundView addSubview:blackMask];
                /**加阴影*/
                [shadowImageView removeFromSuperview];
                shadowImageView.frame=CGRectMake(-10, 0, 10, topView.frame.size.height);
                [topView addSubview:shadowImageView];
            }
            self.backgroundView.hidden = NO;
            //把上一个的viewController 放到screenshot 上面  待滑动结束的时候再移回原来的父试图
            UIViewController *preVC = [self getPreViewController];
            [lastScreenShotView addSubview:preVC.view];
            
        }else if(slideType==0&&absDisY>10&&absDisY>disx){
            slideType=2;
        }
    }else if(slideType==1&&recoginzer.state == UIGestureRecognizerStateEnded){
        if (touchPoint.x - downPoint.x > 50){
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:__gScreenWidth];
            } completion:^(BOOL finished) {
                [self gestureBackAnimationEnd:1];
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                [self gestureBackAnimationEnd:0];
            }];
        }
        return;
    }else if (slideType==1&&recoginzer.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            [self gestureBackAnimationEnd:0];
        }];
        return;
    }
    // it keeps move with touch
    if (_isMoving&&slideType==1) {
        [self moveViewWithX:touchPoint.x - downPoint.x];
    }
}
/*手势动画结束，type0恢复显示结束，type=1隐藏结束*/
-(void)gestureBackAnimationEnd:(int)type{
    UIViewController *preVC = [self getPreViewController];
    [preSuperView addSubview:preVC.view];
    if(type==0){//恢复显示结束
        _isMoving = NO;
        slideType=0;
        self.backgroundView.hidden = YES;
        if(myHorizontalScrollView!=nil){
            myHorizontalScrollView.scrollEnabled=YES;
        }
        if(myVerticalScrollView!=nil){
            myVerticalScrollView.scrollEnabled=YES;
        }
    }else if(type==1){//隐藏结束
        if(isNowViewNeedBackToRoot){
            [self popToRootViewControllerAnimated:NO];
        }else{
            [self popViewControllerAnimated:NO];
        }
        UIView *topView=self.view;
        CGRect frame = topView.frame;
        frame.origin.x = 0;
        topView.frame = frame;
        _isMoving = NO;
        slideType=0;
        self.backgroundView.hidden = YES;
    }
}

@end
