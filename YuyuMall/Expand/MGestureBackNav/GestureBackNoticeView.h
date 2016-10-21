//
//  GestureBackNoticeView.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureBackNoticeView : UIView<UIGestureRecognizerDelegate>{
//    UIImageView *backView;
    float downX,downY;
    /*0默认值，1侧滑，2上下滑*/
    int slideType;
    BOOL isMoving,isNoticeFinished;
}

@end
