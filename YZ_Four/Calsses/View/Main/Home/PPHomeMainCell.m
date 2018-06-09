//
//  PPHomeMainCell.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/4.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPHomeMainCell.h"
#import "UIView+PPAddition.h"
@implementation PPHomeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.bgView borderCorlor_set:Door_TitleGray_color width:0.5 radius:5.0f];
    self.contentView.backgroundColor = Door_BGGray_color;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
