//
//  ViewController.m
//  PPEventDemo
//
//  Created by Liao PanPan on 2018/5/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
@interface ViewController ()
{
    CustomButton *cornerButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    cornerButton = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    cornerButton.backgroundColor = [UIColor blueColor];
    [cornerButton addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cornerButton];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)doAction:(id)sender{
    NSLog(@"click");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
