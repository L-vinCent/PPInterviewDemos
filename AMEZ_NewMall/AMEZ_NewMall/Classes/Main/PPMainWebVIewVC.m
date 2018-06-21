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
#import "PPShowPayView.h"
#import <AFNetworking/AFNetworking.h>
#import "shareView.h"
#import "UIImage+compressIMG.h"
#import "UIImageView+WebCache.h"

static const CGFloat VHeight = 180;
@interface PPMainWebVIewVC ()<UIWebViewDelegate,WXApiDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property(nonatomic,strong)webProgressLine *progressLine;
@property(nonatomic,strong)PPShowPayView *showV;
@property(nonatomic,strong)NSString *pushUrl;  //跳转链接
@property(nonatomic,strong)NSString *pushDesc;  //跳转描述
@property(nonatomic,strong)UIImage *pushImage; //跳转图片
@property(nonatomic,strong)NSString *pushTitle;  //跳转链接
@property(nonatomic,strong)NSString *produtId;  //产品ID
@property(nonatomic,strong)NSString *productName;  //产品名称
@property(nonatomic,strong)NSURLRequest *globalRequest;
@property(nonatomic,copy)WVJBResponseCallback callBack;
@end

@implementation PPMainWebVIewVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self hiddenLeftBarItem:YES];
    

    self.navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"gd_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    
    [self webviewConfig];
    [self registShareFunction];
    [self registAPPGetInfoFunction:self.bridge];
    [self regist_wxPayFunction];
    self.navItem.title = @"艾美e族商城";
    self.isCanSideBack = YES;
 
    LISTEN_NOTIFY(noti_PayResult, self, @selector(payResult:));
    
    
    shareView *shareV = [[shareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - VHeight, SCREEN_WIDTH, VHeight)];
    
    _showV = [[PPShowPayView alloc]initWithDelListView:shareV frame:self.view.bounds];
    
    __weak PPMainWebVIewVC *weakSelf = self;
    shareV.btnClickBlock = ^(NSInteger tag) {
      
        NSLog(@"%ld",(long)tag);
        [weakSelf.showV exitClick];
        [weakSelf shareEventDeal:tag];
        
    };
    [self.view addSubview:_showV];
    
}

-(void)reloadWebview
{
    
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.globalRequest];
    [self.webView reload];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
 
}
-(void)shareEventDeal:(NSInteger )tag
{
    
    switch (tag) {
        case 0:
        {
            //刷新
            [self reloadWebview];
        }
            break;
        case 1:
        {
            //分享给朋友
            [self shareToScene:WXSceneSession];
           
        }
            break;
        case 2:
        {
            //分享给朋友圈
            
            [self shareToScene:WXSceneTimeline];
        }
            break;
        default:
        {
            //复制链接
//            NSLog(@"%@",)
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            [pab setURL:[NSURL URLWithString:self.pushUrl]];
            if(nil != pab) [PPHUDHelp showMessage:@"复制成功"];
        }
            break;
    }
}

-(void)shareToScene:(NSInteger)scene
{
 
    self.pushDesc = @"";
    self.pushImage = [UIImage IMGCompressed:[UIImage imageNamed:@"share_home_icon"] targetWidth:200];
    self.productName = @"";
    NSArray *desArray = [self shareArr];
    for (NSDictionary *dic in desArray) {
        [self setShareValue:dic];
    }
    
    //如果是详情页，需要获取详情页图片，这里的分享放到获取到图片之后
    if ([self.pushTitle isEqualToString:@"产品详情"]) {
        
        [self ProductDetailInfo:scene];
        return;
    }
    
    [self son_shareToScene:scene];
    
}

-(void)son_shareToScene:(NSInteger)scene
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        WXMediaMessage *messsage = [WXMediaMessage message];
        
        messsage.title = kStringIsEmpty(self.productName)?self.pushTitle:self.productName;
        
        messsage.description = kStringIsEmpty(self.pushDesc)?self.pushUrl:self.pushDesc;
        if(!kObjectIsEmpty(self.pushImage)) [messsage setThumbImage:self.pushImage];
        
        WXWebpageObject *obj = [WXWebpageObject object];
        obj.webpageUrl = self.pushUrl;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.message = messsage;
        req.bText = NO;
        
        messsage.mediaObject = obj;
        req.scene = scene;
        [WXApi sendReq:req];
    });
   
}

-(void)setShareValue:(NSDictionary *)dic
{
    NSString *title = [dic objectForKey:@"title"];

    if ([title isEqualToString:self.pushTitle]) {
        self.pushDesc = dic[@"des"];
        NSString *url = dic[@"iconUrl"];
        NSString *imageName =kStringIsEmpty(url)?@"share_home_icon":url;
        UIImage *image = [UIImage imageNamed:imageName];
        self.pushImage = [UIImage IMGCompressed:image targetWidth:200];
        
    }
    
}




- (void)registShareFunction
{
    [_bridge registerHandler:@"webPushNotify" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *url = [tempDic objectForKey:@"url"];
        self.pushTitle = title;

        
        NSMutableString *urlmut = url.mutableCopy;
        if([urlmut hasPrefix:@"/"]){
            [urlmut deleteCharactersInRange: [urlmut rangeOfString:@"/"]];
        }
        
        if([title isEqualToString:@"产品详情"]){
            //获取goodsId
            NSArray *array = [url componentsSeparatedByString:@"?"];
            NSMutableString *goodStr = [[array lastObject] mutableCopy];
            [goodStr deleteCharactersInRange:[goodStr rangeOfString:@"goodsId="]];
            self.produtId = goodStr;
            
        }
 
        
        
        //判断4个tab页，隐藏导航栏返回按钮
        self.pushUrl = [NSString stringWithFormat:@"%@%@",Base_H5URL,urlmut];
        NSArray *urls = @[@"/",@"/shoppingCart",@"/newsIndex",@"/showPClass"];
        [self hiddenLeftBarItem:[urls containsObject:url]?YES:NO];
        // 将分享的结果返回到JS中
        self.navItem.title = title;
        NSLog(@"------%@",url);
        //        responseCallback(result);
        
        
        
    }];
    
}

-(void)rightClick
{
   
    [_showV showWithHeight:VHeight];

    
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
 
    CGFloat webHeight = DeviceIsiPhoneX()?SCREEN_HEIGHT-kDoorNavStatusHeight-0:SCREEN_HEIGHT-kDoorNavStatusHeight;
    
    CGRect rect = CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH, webHeight);
    
    
    
    self.webView= [[UIWebView alloc] initWithFrame:rect];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];

//    NSURLRequest *request  = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:Base_H5URL]];
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Base_H5URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    self.globalRequest = request;
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
    
//    [self.bridge callHandler:@"payResult" data:@{@"result":@"1"} responseCallback:^(id responseData) {
//
//        NSLog(@"------------%@",responseData);
//
//    }];
    
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


-(void)ProductDetailInfo:(NSInteger)scene
{
   
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    LOADING_SHOW
    [manager GET:Product_detail(self.produtId) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
   
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LOADING_HIDE
        NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"----%@",Dic);
        NSDictionary *dataDic = [Dic objectForKey:@"data"];
        
        if(!kObjectIsEmpty(dataDic)){
            
            NSString *imageUrl = [dataDic objectForKey:@"imageUrl"];
            self.productName = [dataDic objectForKey:@"goodsName"];
            NSArray *array = [imageUrl componentsSeparatedByString:@","];
            if(!kArrayIsEmpty(array)) {
                
            NSString *imageStr = array[0];
                
                [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageDownloaderProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                    
                    
                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    
                    if (finished) {
                        
                        self.pushImage = [UIImage IMGCompressed:image targetWidth:200];
                        [self son_shareToScene:scene];

                    }
                    
                    
                }];
                
            }
            
          
            
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        LoADING_FAIL
        
    }];

    
    
    
}



-(NSArray *)shareArr
{
    
    return @[
             @{@"title":@"艾美e族商城",@"des":@"品质优选 全新升级上线",@"iconUrl":@""},
             @{@"title":@"积分商城",@"des":@"美物随心兑，多·快·好·省",@"iconUrl":@"integralShop"},
             @{@"title":@"积分商城详情",@"des":@"美物随心兑，多·快·好·省",@"iconUrl":@"integralShop"},
             @{@"title":@"产品详情",@"des":@"品质优选，购品质省更多",@"iconUrl":@""},
             @{@"title":@"店铺详情",@"des":@"艾美购物 品质优选",@"iconUrl":@""},
             @{@"title":@"艾美头条",@"des":@"每日精彩等你来",@"iconUrl":@"amtv"},
             @{@"title":@"货栈美链",@"des":@"被千万用户认可的经典爆款",@"iconUrl":@"Boutique"},
             @{@"title":@"热卖榜",@"des":@"发现最热销的商品，更优享品质！",@"iconUrl":@"hotsale"},
             @{@"title":@"商家榜",@"des":@"聚焦最佳店铺，收藏精选商家",@"iconUrl":@""},
             @{@"title":@"粉丝收益榜",@"des":@"粉丝收益排名，掀起涨粉丝的大热",@"iconUrl":@""},
             @{@"title":@"一卡通",@"des":@"一卡在手，支付无忧更优惠",@"iconUrl":@""},

             ];
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
    [PPHudLoading closeLoading];
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
