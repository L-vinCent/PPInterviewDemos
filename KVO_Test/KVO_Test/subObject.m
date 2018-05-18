//
//  subObject.m
//  KVO_Test
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "subObject.h"

@implementation subObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));

    }
    return self;
}

-(void)sayHi
{
    
    NSLog(@"subobject_hi");
    
}

@end
