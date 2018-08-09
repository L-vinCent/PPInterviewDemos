//
//  PPLoginMainVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPLoginMainVC.h"
#import "PPRegistVC.h"
#import "PPLoginViewModel.h"
#import "NSString+PPValidStr.h"
@interface PPLoginMainVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *passWordFiled;
@property(nonatomic,strong)PPLoginViewModel *viewModel;
@end

@implementation PPLoginMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.navigationBar setHidden:YES];
    
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    
    [self bindModel];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!kStringIsEmpty(USER_SYN.user)) {
        
        self.phoneFiled.text = USER_SYN.user;
        
    }
    
}

- (void)bindModel {
    
    self.viewModel = [[PPLoginViewModel alloc] init];
    RAC(self.viewModel, userName) = _phoneFiled.rac_textSignal;
    RAC(self.viewModel, password) = _passWordFiled.rac_textSignal;
    
    
}
- (IBAction)goRegistEvent:(id)sender {
    PPRegistVC *vc = [[PPRegistVC alloc]initWithNibName:@"PPRegistVC" bundle:0];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)login_function:(id)sender {
    
    if (kStringIsEmpty(self.phoneFiled.text)) {
        
        [PPHUDHelp showMessage:@"手机号不能为空" afterDelayTime:1];
        return;
    }
    
    if (![self.phoneFiled.text isValidateMobile]) {
        [PPHUDHelp showMessage:@"不合法的手机号" afterDelayTime:1];
        return;
    }
  
    if (kStringIsEmpty(self.passWordFiled.text)) {
        
        [PPHUDHelp showMessage:@"密码不能为空" afterDelayTime:1];
        return;
    }
    [self.viewModel photoCodeLogin];
    
    
}



@end
