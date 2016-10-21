//
//  OnePixLineView.m
//  YuyuMall
//
//  Created by rock on 16/12/05.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "OnePixLineView.h"

@interface OnePixLineView ()
{
    PixLinePosition _position;
}
@end

@implementation OnePixLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _position = PixLineBottom;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame position:(PixLinePosition)position
{
    self = [super initWithFrame:frame];
    if (self) {
        _position = position;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIScreen *screen = [UIScreen mainScreen];
    
    if (screen.scale > 1.0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        
        CGMutablePathRef pathTemp = CGPathCreateMutable();
        
        CGPoint point1 = CGPointZero;
        CGPoint point2 = CGPointZero;
        switch (_position) {
            case PixLineBottom:
                point1 = CGPointMake(0, CGRectGetHeight(rect)-0.25);
                point2 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-0.25);
                break;
            case PixLineTop:
                point1 = CGPointMake(0, 0.25);
                point2 = CGPointMake(CGRectGetWidth(rect), 0.25);
                break;
            case PixLineLeft:
                point1 = CGPointMake(0.25, 0);
                point2 = CGPointMake(0.25, CGRectGetHeight(rect));
                break;
            case PixLineRight:
                point1 = CGPointMake(CGRectGetWidth(rect)-0.25, 0);
                point2 = CGPointMake(CGRectGetWidth(rect)-0.25, CGRectGetHeight(rect));
                break;
            default:
                point1 = CGPointMake(0, CGRectGetHeight(rect)-0.25);
                point2 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-0.25);
                break;
        }
        CGPoint points[] = {point1,point2};
        CGPathAddLines(pathTemp, NULL, points, 2);
        
        CGContextAddPath(context, pathTemp);
        CGContextDrawPath(context, kCGPathStroke);
        CGPathRelease(pathTemp);
    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        
        CGMutablePathRef pathTemp = CGPathCreateMutable();
        CGPoint point1 = CGPointZero;
        CGPoint point2 = CGPointZero;
        switch (_position) {
            case PixLineBottom:
                point1 = CGPointMake(0, CGRectGetHeight(rect)-0.5);
                point2 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-0.5);
                break;
            case PixLineTop:
                point1 = CGPointMake(0, 0.5);
                point2 = CGPointMake(CGRectGetWidth(rect), 0.5);
                break;
            case PixLineLeft:
                point1 = CGPointMake(0.5, 0);
                point2 = CGPointMake(0.5, CGRectGetHeight(rect));
                break;
            case PixLineRight:
                point1 = CGPointMake(CGRectGetWidth(rect)-0.5, 0);
                point2 = CGPointMake(CGRectGetWidth(rect)-0.5, CGRectGetHeight(rect));
                break;
            default:
                point1 = CGPointMake(0, CGRectGetHeight(rect)-0.5);
                point2 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-0.5);
                break;
        }
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetShouldAntialias(context, true);
        CGPoint points[] = {point1,point2};
        CGPathAddLines(pathTemp, NULL, points, 2);
        
        CGContextAddPath(context, pathTemp);
        CGContextDrawPath(context, kCGPathStroke);
        CGPathRelease(pathTemp);
    }
}

@end
