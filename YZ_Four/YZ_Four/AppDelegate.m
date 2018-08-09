//
//  AppDelegate.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/4.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "AppDelegate.h"
#import "PPMainViewController.h"
#import "PPNavViewController.h"
#import "PPLoginMainVC.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; //创建新的窗口
    [HYBNetworking updateBaseUrl:Base_H5URL];
    
    
    //键盘事件处理
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    PPMainViewController *main=[[PPMainViewController alloc]init];
    [self.window setRootViewController:main];
    [self.window makeKeyAndVisible];
    
    [self checkLogin];
    
    return YES;
    
}



-(void)checkLogin
{
    
    if (!kStringIsEmpty(USER_SYN.token)) {

        [self setRootVC];

    }else
    {
        [self goLoginVC];


    }
 
}

-(void)setRootVC
{
    PPMainViewController *main=[[PPMainViewController alloc]init];
    [self.window setRootViewController:main];
    [self.window makeKeyAndVisible];
}

-(void)goLoginVC
{
    PPLoginMainVC *vc=[[PPLoginMainVC alloc]init];
    PPNavViewController *nav=[[PPNavViewController alloc]initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
