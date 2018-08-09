//
//  PPRegistVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPRegistVC.h"
#import "PPLoginViewModel.h"
#import "NSString+PPValidStr.h"
#import "JKCountDownButton.h"
@interface PPRegistVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *codeFiled;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeFiled;
@property(nonatomic,strong)PPLoginViewModel *viewModel;
@property (weak, nonatomic) IBOutlet JKCountDownButton *jkCountBtn;

@end

@implementation PPRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationBar setHidden:YES];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [self bindModel];
    [self CountBtnConfig];
    
}
- (void)bindModel {
    
    self.viewModel = [[PPLoginViewModel alloc] init];
    
    RAC(self.viewModel, userName) = _phoneFiled.rac_textSignal;
    RAC(self.viewModel, password) = _codeFiled.rac_textSignal;
    RAC(self.viewModel, code) = _smsCodeFiled.rac_textSignal;

    
}


- (IBAction)Regist_function:(id)sender {
    
 
    
    if (kStringIsEmpty(self.phoneFiled.text)) {
        
        [PPHUDHelp showMessage:@"手机号不能为空" afterDelayTime:1];
        return;
    }
    
    if (![self.phoneFiled.text isValidateMobile]) {
        [PPHUDHelp showMessage:@"不合法的手机号" afterDelayTime:1];
        return;
    }
    
    if (kStringIsEmpty(self.codeFiled.text)) {
        
        [PPHUDHelp showMessage:@"密码不能为空" afterDelayTime:1];
        return;
    }
    
    if (self.codeFiled.text.length<6) {
        
        [PPHUDHelp showMessage:@"密码不能小于6位" afterDelayTime:1];
        return;
    }
    
    
    if (kStringIsEmpty(self.smsCodeFiled.text)) {
        
        [PPHUDHelp showMessage:@"验证码不能为空" afterDelayTime:1];
        return;
    }
   
    
    
    
    [self.viewModel registAccount];
    [self.viewModel.successSubject subscribeNext:^(id  _Nullable x) {
       
        [self.navigationController popViewControllerAnimated:YES];
    
       
        
    }];
}


-(void)CountBtnConfig{
    
    [self.jkCountBtn countDownButtonHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
        
        if (![self.phoneFiled.text isValidateMobile]) {
            [PPHUDHelp showMessage:@"请输入合法手机号" afterDelayTime:1];
            return;
        }
        [self.viewModel getSmsCode:_phoneFiled.text];
        
        [self.viewModel.successSubject subscribeNext:^(id  _Nullable x) {
            //验证码发送成功,启动倒计时
           
            countDownButton.enabled=NO;
            NSInteger time=60;
            [countDownButton startCountDownWithSecond:60];
            [countDownButton setTitle:[NSString stringWithFormat:@"%zd秒后重发",time] forState:UIControlStateNormal];
            [countDownButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"%zd秒后重发",second];
                return title;
            }];
            
            [countDownButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"点击重新获取";
                
            }];
            
        }];
        
        
      
        
        
    }];
}


@end
