//
//  ButtonUtil.m
//  TestLayer
//
//  Created by richard on 16/1/19.
//  Copyright © 2016年 richard. All rights reserved.
//

#import "ButtonUtil.h"

@implementation ButtonUtil


/**
 *  该类方法可以为button添加实线边框，可指定button的任意几条或全部边
 *
 *  @param button  想要添加边框的那个button
 *  @param color   边框颜色
 *  @param width   边框宽度
 *  @param borders 可使用该值任意指定其中的几个或全部边如(UIButtonBorderTop|UIButtonBorderRight)可以指定绘制上边和右边
 */
+(void)addBorder:(UIButton*)button borderColor:(UIColor*)color borderWidth:(NSInteger)width borders:(UIButtonBorder)borders;
{
    BOOL drawTop = borders & 0x01;
    BOOL drawRight = borders >> 1 & 0x01 ;
    BOOL drawBottom = borders >> 2 & 0x01;
    BOOL drawLeft = borders >> 3 & 0x01;
    if (drawTop) {
        CALayer *topLayer = [CALayer layer];
        //boder color
        topLayer.backgroundColor = color.CGColor;
        //border frame
        topLayer.frame = CGRectMake(0, 0, button.bounds.size.width, width);
        
        [button.layer addSublayer:topLayer];

    }
    
    if (drawRight) {
        CALayer *rightLayer = [CALayer layer];
        rightLayer.backgroundColor = color.CGColor;
        rightLayer.frame = CGRectMake(button.bounds.size.width, 0, width, button.bounds.size.height);
        [button.layer addSublayer:rightLayer];
        
    }
    
    if (drawBottom) {
        CALayer *bottomLayer = [CALayer layer];
        //boder color
        bottomLayer.backgroundColor = color.CGColor;
        //由于绘制底部的border时候不能够充满底部，如果border宽度很宽的话，会很难看，所以
        //底部的长度要加上 width
        bottomLayer.frame = CGRectMake(0, button.bounds.size.height, button.bounds.size.width + width, width);
        
        [button.layer addSublayer:bottomLayer];
    }
    
    if (drawLeft) {
        CALayer *rightLayer = [CALayer layer];
        rightLayer.backgroundColor = color.CGColor;
        rightLayer.frame = CGRectMake(0, 0, width, button.bounds.size.height);
        [button.layer addSublayer:rightLayer];

    }
    
}



/**
 *  该类方法可以为button添加虚线边框，可指定button的任意几条或全部边
 *
 *  @param button  想要添加边框的那个button
 *  @param color   边框颜色
 *  @param width   边框宽度
 *  @param borders 可使用该值任意指定其中的几个或全部边如(UIButtonBorderTop|UIButtonBorderRight)可以指定绘制上边和右边
 */
+(void)addDottedBorder:(UIButton*)button borderColor:(UIColor*)color borderWidth:(NSInteger)width borders:(UIButtonBorder)borders{
    BOOL drawTop = borders & 0x01;
    BOOL drawRight = borders >> 1 & 0x01 ;
    BOOL drawBottom = borders >> 2 & 0x01;
    BOOL drawLeft = borders >> 3 & 0x01;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = button.bounds;
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    shapeLayer.lineWidth = width;
    // 设置虚线颜色
    [shapeLayer setStrokeColor:[color CGColor]];
    // 4=线的宽度 2=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:4],
      [NSNumber numberWithInt:2],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (drawTop) {
        CGPathAddLineToPoint(path, NULL, button.bounds.size.width,0);
    }else{
        CGPathMoveToPoint(path, NULL, button.bounds.size.width, 0);
    }
    if (drawRight) {
        CGPathAddLineToPoint(path, NULL, button.bounds.size.width,button.bounds.size.height);
    }else{
        CGPathMoveToPoint(path, NULL, button.bounds.size.width, button.bounds.size.height);
    }
    if (drawBottom) {
        CGPathAddLineToPoint(path, NULL, 0,button.bounds.size.height);
    }else{
        CGPathMoveToPoint(path, NULL, 0, button.bounds.size.height);
    }
    if (drawLeft) {
        CGPathAddLineToPoint(path, NULL, 0, 0);
    }
    else{
        //do nothing
    }
    
    [shapeLayer setPath:path];
    [button.layer addSublayer:shapeLayer];
    CGPathRelease(path);
}
@end
