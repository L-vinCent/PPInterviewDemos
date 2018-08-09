//
//  PPVerifyUserVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPVerifyUserVC.h"
#import "PPVerifyUserVIew.h"
@interface PPVerifyUserVC ()

@end

@implementation PPVerifyUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     PPVerifyUserVIew *v = [[[NSBundle mainBundle]loadNibNamed:@"PPVerifyUserVIew" owner:self options:0]lastObject];
    v.frame = self.view.bounds;
    [self.view addSubview:v];
    
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
