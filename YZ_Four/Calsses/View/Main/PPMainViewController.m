//
//  PPMainViewController.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPMainViewController.h"
#import "PPBaseViewController.h"
#import "PPNavViewController.h"
#import "PPLoginMainVC.h"
@interface PPMainViewController ()

@property(nonatomic,strong)UIButton *composeButton;

@end

@implementation PPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupComposeButton];
    [self setupChildControllers];
}



#pragma mark 点击事件处理
-(void)composeStatus
{
    NSLog(@"");
    
}

#pragma mark 辅助函数
-(UIViewController *)controller:(NSDictionary *)dic
{
    if (kDictIsEmpty(dic)) {
        return [[UIViewController alloc]init];
    }
    
    NSString *clsName = dic[@"clsName"];
    NSString *title = dic[@"title"];
    NSString *imageName=dic[@"imageName"];

  
    
    Class class = NSClassFromString(clsName);
    PPBaseViewController *baseVC=(PPBaseViewController *)[[class alloc]init];
    
    if ([clsName isEqualToString:@"PPLoginMainVC"]) {
        
         baseVC = [[PPLoginMainVC alloc]initWithNibName:@"PPLoginMainVC" bundle:0];
        
    }
    
    NSString *tabImage=[NSString stringWithFormat:@"tabbar_%@.png",imageName];
    
    NSString *selectImageName=[NSString stringWithFormat:@"tabbar_%@_selected.png",imageName];
    
    baseVC.tabBarItem.image=[UIImage imageNamed:tabImage];
    
    baseVC.title=title;
    

    
    [UITabBar appearance].translucent=NO;
    [[UITabBar appearance]setBarTintColor:RGB(254, 254, 254)];
    baseVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [baseVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Door_Global_title} forState:UIControlStateSelected];

    PPNavViewController *nav=[[PPNavViewController alloc]initWithRootViewController:baseVC];
    
    return nav;
    
}
#pragma mark 代理方法
#pragma mark 视图处理

-(void)setupChildControllers
{
    NSArray *array=@[
                    @{@"clsName":@"PPHomeMainVC",@"title":@"赛事",@"imageName":@"home"},
                    @{@"clsName":@"PPLoginMainVC",@"title":@"礼品中心",@"imageName":@"message_center"},
                    @{@"clsName":@"PPJWTMainHomeVC",@"title":@"奖武堂",@"imageName":@"discover"},
                    @{@"clsName":@"PPScoreMainVC",@"title":@"战绩",@"imageName":@"profile"},
                    @{@"clsName":@"PPMineMainVC",@"title":@"我的",@"imageName":@"profile"},
    ];
    
    NSMutableArray *vcArray=@[].mutableCopy;
    
    for (NSDictionary *dic in array) {
    
        [vcArray addObject:[self controller:dic]];
        
    }
    self.viewControllers=vcArray;
    
}

-(void)setupComposeButton
{
    [self.tabBar addSubview:self.composeButton];
    NSInteger count = self.childViewControllers.count;
    CGFloat w=self.tabBar.PP_width/count;
    _composeButton.frame=CGRectInset(self.tabBar.bounds,2*w,0);
    
    [_composeButton addTarget:self action:@selector(composeStatus) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 懒加载
-(UIButton *)composeButton
{
    if (!_composeButton) {
        
        _composeButton=[UIButton cz_imageButton:@"tabbar_compose_icon_add" backgroundImageName:@"tabbar_compose_button"];
        
    }
    
    return _composeButton;
}




@end
