//
//  PPDetailTwoCell.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/6.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPDetailTwoCell.h"

@implementation PPDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.numberLabel radiusSetByRect:CGSizeMake(14, 14) byRoundingCorners:UIRectCornerAllCorners];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

   
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    
}

@end
