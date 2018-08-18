//
//  PPBindMainView.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPBindMainView.h"

@interface PPBindMainView()

@property(nonatomic,copy)fuzhuClick clickBlock;
@property(nonatomic,copy)NSArray* fzArray;

@end

@implementation PPBindMainView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.BindBtn setBackgroundColor:Door_BGGlobal_color];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.BindBtn radiusSetByRect:CGSizeMake(8, 8) byRoundingCorners:UIRectCornerAllCorners];

}

-(void)loadFuZhuArrays:(NSArray *)fuzhuArr ClickContents:(fuzhuClick)clockBlock
{
    self.fzArray = fuzhuArr;
    
    for (int i=0; i<fuzhuArr.count; i++) {
    
        NSString *character = fuzhuArr[i];
        CGFloat spacing = 10;
        CGFloat labelWidth = 35;
//        UILabel *label  = [UILabel cz_labelWithText:character fontSize:14 color:[UIColor whiteColor]];
        UIButton *btn = [UIButton cz_textButton:character fontSize:14 normalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor]];
        [btn setBackgroundColor:Door_BGGlobal_color];
        btn.frame = CGRectMake(16+(labelWidth+spacing)*i, 0, labelWidth, 31);
        [btn radiusSetByRect:CGSizeMake(3, 3) byRoundingCorners:UIRectCornerAllCorners];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.clickBlock = clockBlock;
        [self.fuzhuBGView addSubview:btn];
        
        
    }
    
    
}

-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSString *str =  self.fzArray[btn.tag];
    
    if (self.clickBlock) {
        
        self.clickBlock(str);
        
    }
    
}

@end
