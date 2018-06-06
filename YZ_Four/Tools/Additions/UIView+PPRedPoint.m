//
//  UIView+PPRedPoint.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/25.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "UIView+PPRedPoint.h"



@implementation UIView (PPRedPoint)

#pragma other(redPoint)
//添加显示
- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY {
//    [self removeRedPoint];//添加之前先移除，避免重复添加
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 998;
    
    CGFloat viewWidth = 12;
  
        viewWidth = 18;
        UILabel *valueLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
        valueLbl.tag=1000;
    
        valueLbl.font = XNFont(12);
        valueLbl.textColor = [UIColor whiteColor];
        valueLbl.textAlignment = NSTextAlignmentCenter;
        valueLbl.clipsToBounds = YES;
        [badgeView addSubview:valueLbl];
  
    
    badgeView.layer.cornerRadius = viewWidth / 2;
    badgeView.backgroundColor = [UIColor redColor];
    
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    if (offsetX == 0) {
        offsetX = 1;
    }
    
    if (offsetY == 0) {
        offsetY = 0.05;
    }
    CGFloat x = ceilf(tabFrame.size.width + offsetX);
    CGFloat y = ceilf(offsetY * tabFrame.size.height);
    
    badgeView.frame = CGRectMake(x, y, viewWidth, viewWidth);
    [self addSubview:badgeView];
}

-(void)showRedCount:(NSString *)value
{

    BOOL isHid=value.integerValue?NO:YES;
    
    UIView *v=[self viewWithTag:998];
    [v setHidden:isHid];

    UILabel *label=[v viewWithTag:1000];
    label.text=value;
    
}

-(void)hideRedPoint
{
    UIView *v=[self viewWithTag:998];
    [v setHidden:YES];
}


//移除
- (void)removeRedPoint{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 998) {
            [subView removeFromSuperview];
        }
    }
}

-(void)borderCorlor_set:(UIColor * )color width:(CGFloat)width radius:(CGFloat)radius
{
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=width;
    
    if (radius) {
        self.layer.cornerRadius=radius;
        self.layer.masksToBounds=YES;
    }
    
}

-(void)radiusSetByRect:(CGSize)size byRoundingCorners:(UIRectCorner )rectCorner
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    

 
    self.layer.mask = maskLayer;

}


///**
// ** self:       需要绘制成虚线的view
// ** lineLength:     虚线的宽度
// ** lineSpacing:    虚线的间距
// ** lineColor:      虚线的颜色
// **/
//- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor totalWidth:(int )totalWidth
//{
//    CGRect layerBounds = !totalWidth?lineView.bounds:CGRectMake(0, 0, totalWidth, lineView.PP_height);
//    CGRect layerFrame = !totalWidth?lineView.frame:CGRectMake(lineView.PP_origin.x, lineView.PP_origin.y, totalWidth, lineView.PP_height);
//
//    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:layerBounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(layerFrame) / 2, CGRectGetHeight(layerFrame))];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    
//    //  设置虚线颜色为
//    [shapeLayer setStrokeColor:lineColor.CGColor];
//    
//    //  设置虚线宽度
//    [shapeLayer setLineWidth:CGRectGetHeight(layerFrame)];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    
//    //  设置线宽，线间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
//    
//    //  设置路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(layerFrame), 0);
//    
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    
//    //  把绘制好的虚线添加上来
//    [lineView.layer addSublayer:shapeLayer];
//}

@end
