//
//  PPLoginMainVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPLoginMainVC.h"

#import "PPRegistVC.h"
@interface PPLoginMainVC ()

@end

@implementation PPLoginMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setHidden:YES];
    
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}
- (IBAction)goRegistEvent:(id)sender {
    PPRegistVC *vc = [[PPRegistVC alloc]initWithNibName:@"PPRegistVC" bundle:0];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
