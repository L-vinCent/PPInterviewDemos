//
//  UIView+PPRedPoint.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/25.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PPRedPoint)
- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY;
- (void)hideRedPoint;
-(void)showRedCount:(NSString *)value;

-(void)borderCorlor_set:(UIColor * )color width:(CGFloat)width radius:(CGFloat)radius;


-(void)radiusSetByRect:(CGSize)size byRoundingCorners:(UIRectCorner )rectCorner;

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor totalWidth:(int )totalWidth;

@end
