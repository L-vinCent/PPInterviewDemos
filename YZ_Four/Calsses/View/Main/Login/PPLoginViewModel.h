//
//  PPLoginViewModel.h
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/19.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLoginViewModel : NSObject

@property (nonatomic, strong) NSString   *userName;  //手机号
@property (nonatomic, strong) NSString   *password; //密码
@property (nonatomic, strong) NSString   *code;  //验证码

// 成功信号
@property (nonatomic, strong) RACSubject *successSubject;
// 失败信号
@property (nonatomic, strong) RACSubject *failureSubject;
// 错误信号
@property (nonatomic, strong) RACSubject *errorSubject;


-(void)getSmsCode:(NSString *)phoneNumber;
-(void)photoCodeLogin;
-(void)registAccount;

@end
