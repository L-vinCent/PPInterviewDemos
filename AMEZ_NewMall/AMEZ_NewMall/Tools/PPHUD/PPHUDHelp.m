//
//  PPHUDHelp.m
//  PictureHouseKeeper
//
//  Created by 李亚军 on 16/8/19.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "PPHUDHelp.h"

@implementation PPHUDHelp
{
    
}

+(instancetype)shareinstance{
    
    static PPHUDHelp *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PPHUDHelp alloc] init];
       
   
        
    });
    
    return instance;
    
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode *)myMode{
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode *)myMode customImgView:(UIImageView *)customImgView{
    //如果已有弹框，先消失
    if ([PPHUDHelp shareinstance].hud != nil) {
        [[PPHUDHelp shareinstance].hud hideAnimated:YES];
        [PPHUDHelp shareinstance].hud = nil;
    }
  
    
    
    [PPHUDHelp shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //这里设置是否显示遮罩层
    
    //是否设置黑色背景，这两句配合使用
    [PPHUDHelp shareinstance].hud.bezelView.color = Door_title_color;
    [PPHUDHelp shareinstance].hud.contentColor = [UIColor whiteColor];
    
    [PPHUDHelp shareinstance].hud.opaque=0.8;
    [PPHUDHelp shareinstance].hud.animationType=MBProgressHUDAnimationZoom;
//    [[PPHUDHelp shareinstance].hud setMargin:10];
    [[PPHUDHelp shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [PPHUDHelp shareinstance].hud.detailsLabel.text = msg;
//    [PPHUDHelp shareinstance].hud.alpha=0.8;
    
//    [PPHUDHelp shareinstance].hud.dimBackground=YES;
    
    [PPHUDHelp shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case YJProgressModeOnlyText:
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case YJProgressModeLoading:
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case YJProgressModeCircle:{
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [PPHUDHelp shareinstance].hud.customView = img;
            
            
            break;
        }
        case YJProgressModeCustomerImage:
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [PPHUDHelp shareinstance].hud.customView = customImgView;
            break;
            
        case YJProgressModeCustomAnimation:
            //这里设置动画的背景色
            [PPHUDHelp shareinstance].hud.bezelView.color = [UIColor yellowColor];
            
            
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [PPHUDHelp shareinstance].hud.customView = customImgView;
            
            break;
            
        case YJProgressModeSuccess:
            [PPHUDHelp shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [PPHUDHelp shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
    
    
    
}


+(void)hide{
    if ([PPHUDHelp shareinstance].hud != nil) {
        [[PPHUDHelp shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg {
    [self show:msg inView:kKeyWindow mode:YJProgressModeOnlyText];
    [[PPHUDHelp shareinstance].hud hideAnimated:YES afterDelay:1.0];
}



+(void)showMessage:(NSString *)msg  afterDelayTime:(NSInteger)delay{
    [self show:msg inView:kKeyWindow mode:YJProgressModeOnlyText];
    [[PPHUDHelp shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccess:(NSString *)msg {
    [self show:msg inView:kKeyWindow mode:YJProgressModeSuccess];
    [[PPHUDHelp shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName {
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:kKeyWindow mode:YJProgressModeCustomerImage customImgView:img];
    [[PPHUDHelp shareinstance].hud hideAnimated:YES afterDelay:1.0];
}


+(void)showLoading {
//    NSLog(@"--------%@",kKeyWindow);
    [self show:@"" inView:kKeyWindow mode:YJProgressModeLoading];
}

+(MBProgressHUD *)showProgressCircle:(NSString *)msg {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = msg;
    return hud;
    
    
}

+(void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:kKeyWindow mode:YJProgressModeCircle];
    
}


+(void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[PPHUDHelp shareinstance].hud hideAnimated:YES afterDelay:1.0];
    
}

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry {
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:kKeyWindow mode:YJProgressModeCustomAnimation customImgView:showImageView];
    
    
}

@end
