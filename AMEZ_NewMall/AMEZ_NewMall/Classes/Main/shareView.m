
//
//  shareView.m
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/6/7.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "shareView.h"
#import "UILabel+CZAddition.h"
#import "UIView+PPRedPoint.h"
static const CGFloat HSpace = 10;
static const CGFloat VSpace = 20;

static

@interface shareView()

@property(nonatomic,strong)NSMutableArray *bgViewArrays;

@end

@implementation shareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgViewArrays = @[].mutableCopy;
         [self configViewWithFrame:frame];
    }
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.backgroundColor = [RGB(230,230,230) colorWithAlphaComponent:0.95];
    
   
    for (NSInteger i=0; i<_bgViewArrays.count; i++) {
        
        UIView *iconV = self.bgViewArrays[i];
        iconV.tag = i;
        NSInteger count = _bgViewArrays.count;
        CGFloat averWidth = (SCREEN_WIDTH - (count+1)*HSpace)/count;
        CGFloat averHeight = self.PP_height - 2*VSpace;
        iconV.frame = CGRectMake(HSpace + (averWidth+HSpace)*i , VSpace, averWidth, averHeight);
        
    }
  
    
    
}
-(void)configViewWithFrame:(CGRect)frame
{
    NSArray *configArr = @[
                           @{@"title":@"刷新",@"icon":@"sx_icon",},
                           @{@"title":@"分享给朋友",@"icon":@"fspy_icon",},
                           @{@"title":@"分享给朋友圈",@"icon":@"fxpyq_icon",},
                           @{@"title":@"复制链接",@"icon":@"fzlj_icon",},
                           ];
    
    
    NSInteger count = configArr.count;
    CGFloat averWidth = (SCREEN_WIDTH - (count+1)*HSpace)/count;
    CGFloat averHeight = frame.size.height - VSpace*2;
    
    UIView *(^newIconView)(NSDictionary *dic) = ^UIView *(NSDictionary *dic){
        
        NSString *title = dic[@"title"];
        NSString *icon = dic[@"icon"];
        
        UIView *bgV = [UIView new];
        bgV.backgroundColor = [UIColor clearColor];
        bgV.PP_size = CGSizeMake(averWidth, averHeight);
        bgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareClick:)];
        [bgV addGestureRecognizer:tap];
        [self addSubview:bgV];
        
        CGFloat space = 10.0f;
        UIView *iconbg = [[UIView alloc]initWithFrame:CGRectMake(space, space, bgV.PP_width-space*2, bgV.PP_width-space*2)];
        iconbg.backgroundColor = [UIColor whiteColor];
        [iconbg radiusSetByRect:CGSizeMake(10, 10) byRoundingCorners:UIRectCornerAllCorners];
        [bgV addSubview:iconbg];
        
        UIImageView *imageV = [UIImageView new];
        [imageV setImage:[UIImage imageNamed:icon]];
        imageV.frame = iconbg.bounds;
//        imageV.PP_centerX = iconbg.PP_centerX;
//        imageV.PP_centerY = iconbg.PP_centerY;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [iconbg addSubview:imageV];
        
        UILabel *labelV = [UILabel cz_labelWithText:title fontSize:12 color:Door_TitleGray_color];
        [bgV addSubview:labelV];
        labelV.frame = CGRectMake(0, iconbg.PP_bottom+10, bgV.PP_width, 25);
        labelV.textAlignment = NSTextAlignmentCenter;
        labelV.PP_centerX = bgV.PP_centerX;
        
        return bgV;
        
    };
    
    
    for (NSDictionary *dic in configArr) {
        
        [_bgViewArrays addObject:newIconView(dic)];
        
    }
    
}

-(void)shareClick:(UITapGestureRecognizer *)sender
{
    UIButton *btn = (UIButton *)sender.view;
    if (self.btnClickBlock) {
        
        self.btnClickBlock(btn.tag);
        
    }
    
}
@end
