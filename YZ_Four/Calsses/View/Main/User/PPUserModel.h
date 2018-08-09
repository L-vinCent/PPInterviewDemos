//
//  PPUserModel.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPUserModel : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *boosId;
@property (nonatomic, copy) NSString *registerType;   //注册类型
@property (nonatomic, copy) NSString *token;   //用户token
@property (nonatomic, copy) NSString *cardOpenState;   //用户会否开启优惠折扣
@property (nonatomic, copy) NSString *storeSn;   //财富站点

@property (nonatomic, copy) NSString *loginFlag;   // 登录标识

@property (nonatomic, copy) NSString *storeFlag;   // 门店标识

@property (nonatomic, copy) NSString *bossName; //bossName
@end
