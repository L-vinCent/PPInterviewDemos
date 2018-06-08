//
//  PPGlobaBottomBar.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/29.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPGlobaBottomBar.h"

//static const CGFloat kBtnWidth=80;

@interface PPGlobaBottomBar ()
@property(nonatomic,strong)NSArray *countArray;
@property(nonatomic,copy)clickBMBarBlockName block;
@end
@implementation PPGlobaBottomBar

- (instancetype)initWithFrame:(CGRect)frame countArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.countArray=array;
        [self configUI];
    }
    return self;
}

-(void)setSpecialBtnAtIndex:(NSInteger)index
{
  
    for (int i =0; i<_countArray.count; i++) {
        UIButton *btn=(UIButton *)[self viewWithTag:i+1];
    
        if (index==i+1) {
            //从1开始
            [btn setBackgroundColor:Door_BGGlobal_color];
            [btn setTitleColor:Door_Global_title forState:UIControlStateNormal];

        }else
        {
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:Door_title_color forState:UIControlStateNormal];

        }
   
        
    }
}

-(void)configUI
{
    CGFloat kBtnWidth=(SCREEN_WIDTH)/_countArray.count;
//    CGFloat btnSpace=(self.PP_width-kBtnWidth*_countArray.count)/(_countArray.count+1); //间距
    CGFloat btnSpace=0;
  
    
    for (int i=0; i<_countArray.count; i++) {
    
        UIButton *btn=[UIButton cz_textButton:_countArray[i] fontSize:12 normalColor:Door_title_color highlightedColor:Door_title_color];
        
        btn.tag=i+1;
//        [btn borderCorlor_set:[UIColor blackColor] width:0.5 radius:5];
        btn.frame=CGRectMake(btnSpace+(btnSpace+kBtnWidth)*i, 0, kBtnWidth, self.PP_height);
        btn.PP_centerY=25;
        
       [btn setBackgroundColor:Door_BGGlobal_color];
            [btn setTitleColor:Door_Global_title forState:UIControlStateNormal];

 
        WEAK
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            STRONG
            
            if (self.block) {
                self.block(btn.tag);
            }
            
        }];
        
        [self addSubview:btn];
    }
    
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineV.backgroundColor=Door_BGGray_color;
    [self addSubview:lineV];
    
    
}

-(void)clickBMBarBlock:(clickBMBarBlockName)block
{
    _block=block;
}

@end
