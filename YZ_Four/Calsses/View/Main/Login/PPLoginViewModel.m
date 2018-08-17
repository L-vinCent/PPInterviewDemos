//
//  PPLoginViewModel.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/19.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPLoginViewModel.h"

#import "PPMainViewController.h"

@interface PPLoginViewModel()

/** 用户名改变信号 */
@property (nonatomic, strong) RACSignal *userNameSignal;
/** 密码改变信号 */
@property (nonatomic, strong) RACSignal *passwordSignal;

//验证码改变信号
@property (nonatomic, strong) RACSignal *codeSignal;


@end

@implementation PPLoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        // RACObserve(self, name):监听某个对象的某个属性,返回的是信号。
        _userNameSignal = RACObserve(self, userName);
        _passwordSignal = RACObserve(self, password);
        _codeSignal = RACObserve(self, code);
        
        _successSubject = [RACSubject subject];
        _failureSubject = [RACSubject subject];
        _errorSubject = [RACSubject subject];
    }
    return self;
}

-(void)photoCodeLogin
{
    
    NSString *tempS = [_userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    LOADING_SHOW
    NSDictionary *dict = @{
                           @"loginName":tempS,
                           @"loginPassWord":password,
                           @"loginType":@"loginByPwd",
                           };

    [HYBNetworking postWithUrl:Login_login bodyDict:dict success:^(NSDictionary *response) {

       
        PPBaseApiDataModel *data=[PPBaseApiDataModel mj_objectWithKeyValues:response];

        NSLog(@"%@",response);
        if (STR_EQUAL(data.code, @"111111")) {
        
        
            [PPHUDHelp showSuccess:@"登录成功"];
            
            NSDictionary *dataDic = data.data;
            NSString *token = [dataDic objectForKey:@"token"];
            
            [USER_SYN setToken:token];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [PPHUDHelp showMessage:@"登录成功" afterDelayTime:1];
                
                [self setRootVC];
            });
            
            }else
            {
                
                [PPHUDHelp showMessage:data.message];
            
            }

    } failure:^(NSError *error) {

        LoADING_FAIL
        
    }];
    

    
}

-(void)registAccount
{
    
    NSString *account = [_userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *code = [_code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    LOADING_SHOW
    NSDictionary *dict = @{
                           @"memberComing":@"1",
                           @"mobile":account,
                           @"passWord":password,
                           @"smsCode":code,
                           };
    
    [HYBNetworking postWithUrl:Login_regist bodyDict:dict success:^(NSDictionary *response) {
        
        
        PPBaseApiDataModel *data=[PPBaseApiDataModel mj_objectWithKeyValues:response];
        
        if (STR_EQUAL(data.code, @"111111")) {
            
            NSDictionary *dataDic = data.data;
            NSString *token = [dataDic objectForKey:@"token"];
            [USER_SYN setToken:token];
            [USER_SYN setUser:account];
            //跳转到首页
            [PPHUDHelp showMessage:@"注册成功" afterDelayTime:1];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                
                [self.successSubject sendNext:@""];
                
            });
            
        }else
        {
            [PPHUDHelp showMessage:data.message];
            
        }
    } failure:^(NSError *error) {
        
        LoADING_FAIL

    }];
    
    

    
}



-(void)getSmsCode:(NSString *)phoneNumber
{
    //手机号验证码登录获取验证码

        NSString *tempS = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [HYBNetworking getWithUrl:Login_smsCode(tempS) refreshCache:NO success:^(id response) {
            
            PPBaseApiDataModel *model = [PPBaseApiDataModel mj_objectWithKeyValues:response];
            if (code_success(model.code)) {
                
                [PPHUDHelp showMessage:@"验证码已发送至手机" afterDelayTime:1];
               [self.successSubject sendNext:@""];
            }
            
        } fail:^(NSError *error) {
            
            LoADING_FAIL
            
        }];

}

-(void)setRootVC
{
    
    PPMainViewController *main=[[PPMainViewController alloc]init];
    [kKeyWindow setRootViewController:main];
    [kKeyWindow makeKeyAndVisible];
}

@end
