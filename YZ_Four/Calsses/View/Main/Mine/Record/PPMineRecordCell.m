//
//  PPMineRecordCell.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMineRecordCell.h"

@implementation PPMineRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bgView borderCorlor_set:Door_line_color width:0.5 radius:5.0f];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
