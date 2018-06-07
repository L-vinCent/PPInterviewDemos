//
//  PPShowPayView.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/23.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPShowPayView.h"

@interface PPShowPayView ()


@property(nonatomic,strong)UIView *listView;
@property(nonatomic,strong)UIView *BGView;
//@property(nonatomic,strong)UIButton *delBtn;
@property(nonatomic,strong)UIView *faView;

@property(nonatomic,assign)BOOL isShow;

@end

@implementation PPShowPayView


- (instancetype)initWithDelListView:(UIView *)view frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //        self.backgroundColor=[UIColor grayColor];
        [self setHidden:YES];
        _listView=view;
        //        _height=height;
        _isShow=NO;
        
         }
    return self;
}




-(void)hide
{
 
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGView.alpha = 0;
        _faView.alpha=0;
        
    } completion:^(BOOL finished) {
        
        [self setHidden:YES];
        [_BGView removeFromSuperview];
        [_faView removeFromSuperview];
        
        _isShow=NO;
        
        
    }];
    
    
}




-(void)showWithHeight:(CGFloat )height
{
    
    if(_isShow) return;
    
    [self setHidden:NO];
    _BGView=[UIView new];

    _BGView.frame           = [[UIScreen mainScreen] bounds];
    _BGView.PP_height-=49;
    //    _BGView.tag             = 12345;
    _BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    _BGView.opaque = NO;
    
    //--UIWindow的优先级最高，Window包含了所有视图，在这之上添加视图，可以保证添加在最上面
    [self addSubview:_BGView];
    
    // ------给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [_BGView addGestureRecognizer:gesture];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
    }];
    
    // ------底部弹出的View
    
    
    
    _faView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
    //    [self addSubview:self.faView];
    
    UIView *topV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    topV.backgroundColor=[UIColor whiteColor];
    

    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    self.moneylabel.text= @"";
    self.moneylabel.font = [UIFont systemFontOfSize:16];
    self.moneylabel.textColor = RGB(135, 135, 135);
//    [topV addSubview:_moneylabel];
    
//    [_faView addSubview:topV];
    
    [self addSubview:_faView];
    
    _listView.frame = CGRectMake(0, 30, SCREEN_WIDTH,_faView.PP_height-30);
    
    //    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [_faView addSubview:_listView];
    

    _faView.alpha=0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        //        self.transform = CGAffineTransformMakeTranslation(30, 20);
        _faView.alpha = 1.0;
        
    }];
    
    _isShow=YES;
    
    
}


- (void)exitClick {
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGView.alpha = 0;
        _faView.alpha=0;
  
        
    } completion:^(BOOL finished) {
        
        [self setHidden:YES];
        [_BGView removeFromSuperview];
        [_faView removeFromSuperview];
        
        _isShow=NO;
        
        
    }];
    
}


@end
