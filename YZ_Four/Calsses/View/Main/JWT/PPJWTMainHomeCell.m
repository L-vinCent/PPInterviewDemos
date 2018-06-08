//
//  PPJWTMainHomeCell.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPJWTMainHomeCell.h"

@implementation PPJWTMainHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView borderCorlor_set:[UIColor clearColor] width:0.1 radius:5];
    
    CALayer *subLayer=[CALayer layer];
    subLayer.frame= CGRectMake(15, 10, SCREEN_WIDTH-30, self.bgView.PP_height);
    subLayer.cornerRadius=8;
    subLayer.backgroundColor=[[UIColor clearColor] colorWithAlphaComponent:0.8].CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(3,2);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = 0.8;//阴影透明度，默认0
    subLayer.shadowRadius = 5;//阴影半径，默认3
    [self.contentView.layer insertSublayer:subLayer below:_bgView.layer];
}

@end
