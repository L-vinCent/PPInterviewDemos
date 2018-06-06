//
//  PPMainWebVIewVC.m
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMainWebVIewVC.h"
#import "PPHudLoading.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import <UIKit/UIKit.h>
#import <WXApi.h>
#import "webProgressLine.h"

#import <AFNetworking/AFNetworking.h>
@interface PPMainWebVIewVC ()<UIWebViewDelegate,WXApiDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property(nonatomic,strong)webProgressLine *progressLine;
@property(nonatomic,copy)WVJBResponseCallback callBack;
@end

@implementation PPMainWebVIewVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self hiddenLeftBarItem:YES];
    

    
    [self webviewConfig];
    [self registShareFunction];
    [self registAPPGetInfoFunction:self.bridge];
    [self regist_wxPayFunction];
    self.navItem.title = @"艾美e族商城";
    self.isCanSideBack = YES;
 
    LISTEN_NOTIFY(noti_PayResult, self, @selector(payResult:));
    LOADING_SHOW
    
   
    
    
}

-(void)payResult:(NSNotification *)noti
{
    PayResp *resp = (PayResp *)noti.object;
    
    NSString *result = [NSString stringWithFormat:@"%d",resp.errCode];
    
    if (self.callBack) {
        
        self.callBack(result);
        
    }
    

    
}

-(void)webviewConfig
{
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView= [[UIWebView alloc] initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kDoorNavStatusHeight)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Base_H5URL] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
    NSURLRequest *request  = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:Base_H5URL]];
    [self.webView loadRequest:request];
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    self.progressLine = [[webProgressLine alloc]initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH, 2)];
    self.progressLine.lineColor = Door_progressLine_color;
    [self.view addSubview:self.progressLine];
    
    
    [self backBtnClickEvent:^{
        
        [self.webView goBack];
        
    }];
    
    [self.bridge callHandler:@"payResult" data:@{@"result":@"1"} responseCallback:^(id responseData) {
        
        NSLog(@"------------%@",responseData);
        
    }];
    
}

#pragma mark--WX
-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"wexin";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}



-(void)managerDidRecvPaymentResponse:(PayResp *)response
{
    
    NSLog(@"---%@",response);
    
}

#pragma mark -- registWebFuntion
-(void)regist_wxPayFunction
{
    
    
    [_bridge registerHandler:@"wxPayFuntion" handler:^(id data, WVJBResponseCallback responseCallback) {
       
        self.callBack = responseCallback;
        if(![WXApi isWXAppInstalled])
        {
            [self message_setAlertCT:@"请先安装微信" alertBlock:nil];
            return ;
        }
        
        /*
         "orderNo" : "012018052410551871858129",
         "tradeNo" : "012018052410552258507971",
         "params" : "wxPay"
         */

        
        LOADING_SHOW
        NSDictionary *payDic = (NSDictionary *)data;
        if (kObjectIsEmpty(payDic)) return ;
        
        NSString *orderNo = [data objectForKey:@"orderNo"];
        NSString *tradeNo = [data objectForKey:@"tradeNo"];
        NSString *token = [data objectForKey:@"token"];
        
        
        NSDictionary *Dic = @{@"orderNo":orderNo,
                              @"tradeNo":tradeNo,
                              };
        

        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer new];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        
  
        [manager POST:Third_WXPay parameters:Dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if([[Dic objectForKey:@"code"] isEqualToString:@"0"])
            {
                LOADING_HIDE
                NSDictionary *payDic = [[Dic objectForKey:@"data"]objectForKey:@"resultData"];
                NSMutableString *stamp  = [payDic objectForKey:@"timestamp"];
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [payDic objectForKey:@"partnerid"];
                req.prepayId            = [payDic objectForKey:@"prepayid"];
                req.nonceStr            = [payDic objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [payDic objectForKey:@"package"];
                req.sign                = [payDic objectForKey:@"sign"];
                [WXApi sendReq:req];
            }else
            {
                [PPHUDHelp showMessage:[Dic objectForKey:@"msg"]];
            }
           
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            LoADING_FAIL
            
        }];
      
    }];
    
}


- (void)registShareFunction
{
    [_bridge registerHandler:@"webPushNotify" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
//        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        NSArray *urls = @[@"/mine",@"/",@"/shoppingCart",@"/newsIndex",@"/showPClass"];
      
        [self hiddenLeftBarItem:[urls containsObject:url]?YES:NO];
        // 将分享的结果返回到JS中
        self.navItem.title = title;
        NSLog(@"------%@",url);
//        responseCallback(result);
        
    }];
    
}


- (void)registAPPGetInfoFunction:(WebViewJavascriptBridge *)webViewBridge{
    
    [webViewBridge registerHandler:@"getAppUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSDictionary *dict = @{@"from":@"iOS"};
        responseCallback(dict);
        
    }];
}



-(NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    return nil;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [self.progressLine startLoadingAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    LOADING_HIDE
    UIWebView *web = webView;

//    NSString *allHtml = @"document.documentElement.innerHTML";
//    NSString *htmlNum = @"document.getElementById('title').innerText";


    NSString *htmlTitle = @"document.title";
    

    NSString *titleHtmlInfo = [web stringByEvaluatingJavaScriptFromString:htmlTitle];
    
     
//    NSLog(@"%@",titleHtmlInfo);
    
    self.navItem.title = titleHtmlInfo;
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.progressLine endLoadingAnimation];

    });
  
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * requestString = [[request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
  
//    NSLog(@"url-----%@",request);
    return YES;
}



-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.progressLine endLoadingAnimation];
    LoADING_FAIL
    
}


@end
