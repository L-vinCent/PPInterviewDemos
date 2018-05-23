//
//  UIControl+PPClick.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/22.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (PPClick)

@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔

@end
