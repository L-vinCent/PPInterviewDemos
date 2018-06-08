//
//  PPBaseViewController.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPBaseViewController.h"
#import <objc/runtime.h>



@interface PPBaseViewController ()<UIGestureRecognizerDelegate>


@property(nonatomic,copy)backClick_base backBlock;



@end

@implementation PPBaseViewController





- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    [self.navigationController setNavigationBarHidden:YES];
    
    self.isCanSideBack = YES;
    
//    self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor = Door_BGGray_color;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.navigationBar];
    
    self.navItem=[[UINavigationItem alloc]init];
    
    _navItem.title=self.title;
    
    self.navigationBar.items=@[self.navItem];
    
    [self hiddenLeftBarItem:NO];
    
    self.isCanSideBack = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}


-(void)clickPopToParent_base:(backClick_base)block
{
    self.backBlock = block;
    
}

-(void)popToParent_base
{
    if (self.backBlock) {
        
        self.backBlock();
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];

    }
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

- (void)pushWithVCName:(NSString *)Name
{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", Name];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
 
    [self.navigationController pushViewController:instance animated:YES];
    
}

/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
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






-(void)dealloc
{
    
    NSLog(@"%@已销毁",self);
//    REMOVE_NOTIFY(self);
}



- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    //    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    [PPHUDHelp showSuccess:@"已保存至相册"];
}



-(NSString *)DateFormatterToString:(NSDate *)formatter{
    
    
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:formatter];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    
    return currentDateString;
}

-(void)message_setAlertCT:(NSString *)msg alertBlock:(alertBlock)block;
{
    
    LOADING_HIDE
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
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
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

-(void)message_setAlertCTSure:(NSString *)msg cancelMsg:(NSString *)cancelMsg alertBlock:(alertBlock)block cancelBlock:(alertCancelBlock)cancelBlock
{
    LOADING_HIDE
    UIAlertController *alertController=[UIAlertController
                                        alertControllerWithTitle:@"是否保存此次修改，方便下次编辑"
                                        message:@""
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:cancelMsg style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       if (cancelBlock) {
                                                           
                                                           cancelBlock();
                                                       }
                                                       
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    
    UIAlertAction *okaction = [UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (block) {
            
            block();
        }
    }];
    
    
    [alertController addAction:cancel];
    [alertController addAction:okaction];

    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end
