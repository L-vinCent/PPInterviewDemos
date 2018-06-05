//
//  AppDelegate.m
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "AppDelegate.h"
#import "PPMainWebVIewVC.h"
#import <WXApi.h>
#import "HYBNetworking.h"
@interface AppDelegate ()<WXApiDelegate>

//@property(nonatomic,assign)

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:Third_WXAppid];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; //创建新的窗口
    [self.window makeKeyAndVisible];

    [self setUserAgentForWoapp];
    PPMainWebVIewVC *main=[[PPMainWebVIewVC alloc]init];
    
    [self.window setRootViewController:main];

    
    NSLog(@"----%@",[UIApplication sharedApplication].keyWindow);
    
    return YES;
}

-(void)setUserAgentForWoapp

{
    // Set user agent (the only problem is that we can't modify the User-Agent later in the program)
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = [NSString stringWithFormat:@"%@/amezios",secretAgent];
    
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newUagent, @"UserAgent", nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
    webView = nil;
    
}

-(void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[PayResp class]]) {
        
        PayResp *response = (PayResp *)resp;

        POST_NOTIFY(noti_PayResult, response, nil);
        
    }
    
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
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
