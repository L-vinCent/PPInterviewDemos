//
//  PPUserOBJ.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PPUserModel;
@interface PPUserOBJ : NSObject



+(PPUserOBJ*)sharedUserOBJ;
-(void)setUser:(NSString*)user;    //设置手机号
-(void)setPwd:(NSString*)pwd;      //设置密码
- (void)setUserID:(NSString*)userID;  //商户ID
-(void)setToken:(NSString*)token;      //设置token
-(void)setStoreSn:(NSString*)storeSn;      //设置财富站点
-(void)setLoginFlag:(NSString*)loginFlag;      //登录标识
-(void)setStoreFlag:(NSString*)storeFlag;      //门店标识

-(void)setOpenState_card:(NSString *)openState_card; //是否开启优惠券  0 关 1 开
-(void)setCityLocationName:(NSString *)cityLocationName;


-(NSString *)openState_card;
- (NSString*)user;
- (NSString*)pwd;
- (NSString*)userID;
- (NSString*)token;
- (NSString*)cityLocationName; //定位的城市名
-(NSString*)storeSn;
-(NSString*)loginFlag;
-(NSString*)storeFlag;


- (void)removeAllUserInfo;
-(void)SynAllUserInfo:(PPUserModel *)model;

@end
