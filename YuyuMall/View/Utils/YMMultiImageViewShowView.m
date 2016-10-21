//
//  YMMultiImageViewShowView.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "YMMultiImageViewShowView.h"
#import "UIImageView+WebCache.h"
//#import "STPhotoBrowser.h"
//#import "STPhotoAnimationController.h"

#define kNumOfTag 10000 

@interface YMMultiImageViewShowView ()<UIViewControllerTransitioningDelegate,ETCycleScrollViewDelegate>{
    UIPageControl *_adPageControl;
    NSTimer *_timer;
    NSMutableArray *_imgUrlArray;
    NSArray *_dataArray;
    UIImageView *_selectedImageView;
    BOOL _isTime;
}

@end

@implementation YMMultiImageViewShowView

-(void)dealloc{

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _adCycleScrollView=[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _adCycleScrollView.delegate = self;
        [self addSubview:_adCycleScrollView];
        
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//        //设置点击次数和点击手指数
//        tapGesture.numberOfTapsRequired = 1;
//        tapGesture.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:tapGesture];

        _adPageControl=[[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame)- 280)/2,CGRectGetHeight(frame)-30,280,30)];
        _adPageControl.backgroundColor=[UIColor clearColor];
        [_adPageControl setUserInteractionEnabled:NO];
        _adPageControl.pageIndicatorTintColor = [UIColor pointColor];
        _adPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//        [self addSubview:_adPageControl];
        
        _isCanStatistics = YES;
        
    }
    return self;
}

-(void)tapGesture:(id)sender{
    if (_enableShowBigImage && _imgUrlArray.count > 0) {
        [self dealImage];
    }
    
}

-(IBAction)buttonClick:(UIButton*)sender{
    if (_enableShowBigImage && _imgUrlArray.count > 0) {
        [self dealImage];
    }else{
        if (sender.tag < _dataArray.count) {

        }
    }
    
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [_adCycleScrollView setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [_adPageControl setFrame:CGRectMake((CGRectGetWidth(frame)-280)/2,CGRectGetHeight(frame)-30,280,30)];
}

-(void)setDataWithDataArray:(NSArray *)dataArray{
    if (!_imgUrlArray) {
        _imgUrlArray = [[NSMutableArray alloc] init];
    }
    [_imgUrlArray removeAllObjects];
    _dataArray = dataArray;
    [_imgUrlArray addObjectsFromArray:dataArray];
    [self setAdScrollView];
}


-(void)setAdScrollView{
    [_adCycleScrollView removeAllViews];
    int page=0;
    for (int i=0;i<_imgUrlArray.count;i++) {
        UIImageView *itemImgView=[[UIImageView alloc] initWithFrame:CGRectMake(page*CGRectGetWidth(_adCycleScrollView.frame), 0, CGRectGetWidth(_adCycleScrollView.frame), CGRectGetHeight(_adCycleScrollView.frame))];
        itemImgView.userInteractionEnabled = YES;
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = itemImgView.bounds;
        [clickBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.tag = i;
        [itemImgView addSubview:clickBtn];
        if (_enableShowBigImage) {
             [itemImgView setContentMode:UIViewContentModeScaleAspectFill];
            [itemImgView sd_setImageWithURL:[NSURL URLWithString:[_imgUrlArray objectAtIndex:i]]placeholderImage:[UIImage imageNamed:@"storedetail_empty_bg"]];
        }else{
             [itemImgView setContentMode:UIViewContentModeScaleAspectFill];
            [itemImgView sd_setImageWithURL:[NSURL URLWithString:[_imgUrlArray objectAtIndex:i]]placeholderImage:[UIImage imageNamed:@"storedetail_empty_bg"]];
        }
        [itemImgView setClipsToBounds:YES];
        itemImgView.tag = kNumOfTag + i;
        
        [_adCycleScrollView addView:itemImgView];
        if (i == 0) {
            _selectedImageView = itemImgView;
        }
        page++;
    }
    _adPageControl.numberOfPages=page;
    _adPageControl.currentPage=0;
    if (_adPageControl.numberOfPages <= 1) {
        [_adPageControl setHidden:YES];
    }else{
        [_adPageControl setHidden:NO];
        [self restartTimer];
    }
    
}

- (void)restartTimer{
    if (_timer.isValid) {
        [_timer invalidate];_timer = nil;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(moveToNextScreen) userInfo:nil repeats:YES];
}
//滚动到下一屏图片
-(void)moveToNextScreen{
    _isTime = YES;
    NSInteger nextScreen=_adPageControl.currentPage+1;
    if (nextScreen >=_adPageControl.numberOfPages) {
        nextScreen = 0;
    }
  
    if (nextScreen == 0) {
        [_adCycleScrollView scrollIndexToVisible:nextScreen animated:NO];
    }else{
        [_adCycleScrollView scrollIndexToVisible:nextScreen animated:YES];
    }
}

#pragma mark ETCycleScrollViewDelegate
- (void)cycleScrollViewIndexChanged:(NSInteger)index{
    if (_adPageControl.currentPage!=index) {
        if (_isTime) {
            _isTime = NO;
        }else{
            [self restartTimer];
        }
        _adPageControl.currentPage=index;
        UIImageView *imageView = (UIImageView*)[_adCycleScrollView viewWithTag:kNumOfTag + index];
        if ([imageView isKindOfClass:[UIImageView class]]) {
            _selectedImageView = imageView;
        }
        
        if (_isCanStatistics) {
            if (index < _dataArray.count) {

            }
        }
    }
}

-(void)dealImage{
//    STPhotoBrowser* browser = [[STPhotoBrowser alloc] init];
//    
//    NSMutableArray* photosArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < _imgUrlArray.count; i ++) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:[_imgUrlArray objectAtIndex:i] forKey:@"small_src"];
//        [dic setValue:[_imgUrlArray objectAtIndex:i] forKey:@"big_src"];
//        [photosArray addObject:dic];
//    }
//    
//    browser.photos = photosArray;
//    browser.delegate = self;
//    browser.currentIndex = _adPageControl.currentPage;
//    if(__gSystemVersion >= 7){
//        browser.transitioningDelegate = self;
//    }else {
//        browser.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    }
//    [_referenceController presentViewController:browser animated:YES completion:NULL];
//    
//    [self restartTimer];
}

#pragma mark -
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    if([presented isKindOfClass:[STPhotoBrowser class]]){
//        STPhotoAnimationController* animationController = [[STPhotoAnimationController alloc] init];
//        
//        animationController.referenceImageView =  _selectedImageView;
//        return animationController;
//    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
//    if([dismissed isKindOfClass:[STPhotoBrowser class]]){
//        STPhotoAnimationController* animationController = [[STPhotoAnimationController alloc] init];
//        animationController.referenceImageView =  _selectedImageView;
//        return animationController;
//    }
    return nil;
}

- (void)didScrollToIndex:(NSInteger)index{
    
    UIImageView *imageView = (UIImageView*)[_adCycleScrollView viewWithTag:kNumOfTag + index];
    if ([imageView isKindOfClass:[UIImageView class]]) {
        _selectedImageView = imageView;
    }
    [_adCycleScrollView scrollIndexToVisible:index animated:NO];
    
}

-(void)setOpen{
    _isCanStatistics = YES;
}

-(void)setClose{
    _isCanStatistics = NO;
}
@end
