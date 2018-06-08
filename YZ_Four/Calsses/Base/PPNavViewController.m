//
//  PPNavViewController.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPNavViewController.h"
#import "PPBaseViewController.h"
@interface PPNavViewController ()

@end

@implementation PPNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden=YES;
    

}

    
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count>0) {
        
        viewController.hidesBottomBarWhenPushed=YES;
        
        if ([viewController isKindOfClass:[PPBaseViewController class]]) {
            
//        
//            NSString *title = @"返回";
//            
//            if (self.childViewControllers.count==1) {
//                
//                title=self.childViewControllers.firstObject.title;
// 
//            }
//  
        }
        
    }

    
    [super pushViewController:viewController animated:animated];

}


-(void)popToParent
{
    [self.navigationController popViewControllerAnimated:YES];
}
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
