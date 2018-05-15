//
//  ViewController.m
//  KVO_Test
//
//  Created by Liao PanPan on 2018/5/15.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "ViewController.h"
#import "PPObject.h"
#import "PPObserver.h"
@interface ViewController ()
{
    PPObject *obj;
    PPObserver *observer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    obj = [[PPObject alloc] init];
    observer = [[PPObserver alloc] init];
    
    //调用kvo方法监听obj的value属性的变化
    [obj addObserver:observer forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
    
    //通过setter方法修改value
    obj.value = 1;
    
    // 1 通过kvc设置value能否生效？
    [obj setValue:@2 forKey:@"value"];
    
  
    
}

-(void)dealloc
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
