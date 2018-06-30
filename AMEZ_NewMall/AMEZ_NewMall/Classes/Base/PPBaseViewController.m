//
//  PPBaseViewController.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPBaseViewController.h"


@interface PPBaseViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,copy)backClick_baseBlock tempBackBlock;

@end

@implementation PPBaseViewController





- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isCanSideBack = YES;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.navigationBar];
    
    self.navItem=[[UINavigationItem alloc]init];
    
    _navItem.title=self.title;
    
    self.navigationBar.items=@[self.navItem];
    
    [self hiddenLeftBarItem:NO];
    
    self.isCanSideBack = YES;

}

-(void)backBtnClickEvent:(backClick_baseBlock)block
{
    
    self.tempBackBlock = block;
    
}



-(void)hiddenLeftBarItem:(BOOL)hidden
{
    
    if (!hidden) {
        
        self.navItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back_withtext"] style:UIBarButtonItemStylePlain target:self action:@selector(popToParent_base)];
    }else
    {
        self.navItem.leftBarButtonItem=nil;
    }


}


-(void)popToParent_base
{
    //监听网页事件
    if (self.tempBackBlock) {
        self.tempBackBlock();
    }
}

-(UINavigationBar *)navigationBar
{
    if (!_navigationBar) {
        

        _navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        

        
#ifdef __IPHONE_11_0
        
        
        if (@available(iOS 11.0, *)) {
            
            _navigationBar.frame = CGRectMake(0, kDoorStatusBarHeight,SCREEN_WIDTH, 44);
            
        }
        
#endif
//        _navigationBar.barTintColor=[UIColor cz_colorWithHex:0xF6F6F6];
        _navigationBar.barTintColor=Door_BGGlobal_color;
        _navigationBar.translucent = NO;
        _navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        _navigationBar.tintColor=[UIColor whiteColor];
        UIView *view =[UIView new];
        view.frame=CGRectMake(0, _navigationBar.PP_height-0.5, _navigationBar.PP_width, 0.5);
        view.backgroundColor=RGB(216, 216, 216);
        [_navigationBar addSubview:view];
        
        [self setStatusBarBackgroundColor:Door_BGGlobal_color];
        
    }
    return _navigationBar;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}

-(void)message_setAlertCT:(NSString *)msg alertBlock:(alertBlock)block;
{
    
    UIAlertController *alertController=[UIAlertController
                                        alertControllerWithTitle:@""
                                        message:msg
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       if (block) {
                                                           
                                                           block();
                                                       }
                                                       
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
    
}

-(void)dealloc
{
    
    NSLog(@"%@已销毁",self);
//    REMOVE_NOTIFY(self);
}







-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSLog(@"----%@",NSStringFromClass([self class]));
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];

}



- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    return self.isCanSideBack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

@end
