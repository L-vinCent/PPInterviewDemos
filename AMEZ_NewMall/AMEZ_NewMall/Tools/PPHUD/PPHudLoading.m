//
//  PPHudLoading.m
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPHudLoading.h"

@interface PPHudLoading()

@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIView *failView;

@end

@implementation PPHudLoading

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.alpha = 0;
        
        
    }
    return self;
}

+(PPHudLoading *)sharedHUD
{
    static PPHudLoading *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[PPHudLoading alloc]initWithFrame:kKeyWindow.bounds];
        
    });
    
    return sharedInstance;
}

-(void)setupView
{
    
    
}

+(void)show
{
    PPHudLoading *sharedHUD = [PPHudLoading sharedHUD];
    [sharedHUD setHidden:NO];

    UIView *window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:sharedHUD];
    [sharedHUD addLoading];
    
}


-(void)hide
{
    
    
}

// 请求loading页
- (void)addLoading{
    
    if (!_loadingView) {
        
        self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 100)];
        _loadingView.backgroundColor = [UIColor clearColor];
        [self addSubview:_loadingView];
        self.loadingView = _loadingView;
        self.loadingView.center = self.center;
    }
 
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_loadingView.bounds];
    [_loadingView addSubview:imageView];
  
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.animationImages = @[[UIImage imageNamed:@"share_1"],[UIImage imageNamed:@"share_2"],[UIImage imageNamed:@"share_3"]];
    imageView.animationDuration = 0.5;//设置动画时间
    imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
    
    [imageView startAnimating];
    
}

// 请求失败页
- (void)addLoadingFail{
    
    self.failView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 160)];
    self.failView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.failView];
    self.failView.center = self.center;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadGes:)];
    [self.failView addGestureRecognizer:tap];
    UIImageView *failImgView = [[UIImageView alloc] init];
    [self.failView addSubview:failImgView];
    failImgView.image = [UIImage imageNamed:@"loading_fail"];

}

- (void)reloadGes:(UITapGestureRecognizer *)tap{
    
    [self.failView removeFromSuperview];
    //添加block，传出点击事件
    
    [self addLoading];
}

+ (void)closeLoading{
     PPHudLoading *sharedHUD = [PPHudLoading sharedHUD];
    [sharedHUD setHidden:YES];
    if(sharedHUD.loadingView){
        [sharedHUD.loadingView removeFromSuperview];
    }
}

@end
