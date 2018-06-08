//
//  PPMineMainCell.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/7.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMineMainCell.h"

@implementation PPMineMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
