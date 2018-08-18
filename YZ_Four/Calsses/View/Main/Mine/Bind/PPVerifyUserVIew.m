//
//  PPVerifyUserVIew.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPVerifyUserVIew.h"
@interface PPVerifyUserVIew()
@end

@implementation PPVerifyUserVIew

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [_verifyImage radiusSetByRect:CGSizeMake(32, 32) byRoundingCorners:UIRectCornerAllCorners];

}

-(void)layoutSubviews
{
    [super layoutSubviews];

}
- (IBAction)verifyClick:(id)sender {
    
    if (self.verifyBlock) {
        
        self.verifyBlock();
        
    }
    
}

@end
