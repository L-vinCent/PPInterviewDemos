//
//  webProgressLine.m
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/6/1.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "webProgressLine.h"

@implementation webProgressLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
    
}

-(void)startLoadingAnimation
{
    self.hidden  = NO;
    self.PP_width = 0.0f;
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.PP_width = SCREEN_WIDTH * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            weakSelf.PP_width = SCREEN_WIDTH * 0.9;
        }];
    }];
    
}

-(void)endLoadingAnimation
{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.PP_width = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}
@end
