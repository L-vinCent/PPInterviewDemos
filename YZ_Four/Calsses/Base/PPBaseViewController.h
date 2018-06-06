//
//  PPBaseViewController.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^backClick_base)(void);
typedef void(^alertBlock)(void);
typedef void(^alertCancelBlock)(void);


@interface PPBaseViewController : UIViewController

@property(nonatomic,strong)UINavigationBar *navigationBar;

@property(nonatomic,strong)UINavigationItem *navItem;

@property(nonatomic,assign)BOOL isCanSideBack;


-(void)hiddenLeftBarItem:(BOOL)hidden;

- (void)pushWithVCName:(NSString *)Name;


-(void)showEmptyView:(CGRect)frame title:(NSString *)title;
-(void)hideEmptyView;

- (void)loadImageFinished:(UIImage *)image;  //图片保存到相册


-(void)clickPopToParent_base:(backClick_base)block;

-(void)message_setAlertCT:(NSString *)msg alertBlock:(alertBlock)block;

-(void)message_setAlertCTSure:(NSString *)msg cancelMsg:(NSString *)cancelMsg alertBlock:(alertBlock)block cancelBlock:(alertCancelBlock)cancelBlock;


@end
