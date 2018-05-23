//
//  PPBaseViewController.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^backClick_baseBlock)(void);
typedef void(^alertBlock)(void);


@interface PPBaseViewController : UIViewController

@property(nonatomic,strong)UINavigationBar *navigationBar;

@property(nonatomic,strong)UINavigationItem *navItem;

@property(nonatomic,assign)BOOL isCanSideBack;

-(void)backBtnClickEvent:(backClick_baseBlock)block;
-(void)message_setAlertCT:(NSString *)msg alertBlock:(alertBlock)block;
-(void)hiddenLeftBarItem:(BOOL)hidden;


@end
