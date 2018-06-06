//
//  PPBaseField.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/27.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPBaseField.h"

@implementation PPBaseField

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
}

@end
