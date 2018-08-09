//
//  BindGameInfoVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "BindGameInfoVC.h"
#import "PPBindMainView.h"
#import "PPVerifyUserVC.h"
@interface BindGameInfoVC ()

@end

@implementation BindGameInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItem.title = @"账户绑定";
    
    PPBindMainView *v = [[[NSBundle mainBundle]loadNibNamed:@"PPBindMainView" owner:self options:0]lastObject];
    [v.BindBtn addTarget:self action:@selector(pushToVerify) forControlEvents:UIControlEventTouchUpInside];
    v.frame = self.view.bounds;
    [self.view addSubview:v];
    
    
}

-(void)pushToVerify
{
    PPVerifyUserVC *vc = [[PPVerifyUserVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
