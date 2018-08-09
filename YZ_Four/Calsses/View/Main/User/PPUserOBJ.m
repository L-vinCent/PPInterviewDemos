//
//  PPUserOBJ.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPUserOBJ.h"
#import "PPUserDefault.h"
#import "PPUserModel.h"
@implementation PPUserOBJ


+(PPUserOBJ*)sharedUserOBJ{
    static dispatch_once_t onceToken;
    static PPUserOBJ *sharedUserOBJ = nil;
    dispatch_once(&onceToken,^{
        sharedUserOBJ = [[PPUserOBJ alloc] init];
    });
    return sharedUserOBJ;
}
-(void)setToken:(NSString*)token      //设置密码
{

    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:token forKey:PP_Userdefault_UserToken];
}
-(void)setUser:(NSString *)user{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:user forKey:PP_Userdefault_User];
    
}
-(void)setPwd:(NSString *)pwd{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:pwd forKey:PP_Userdefault_Pwd];
}
- (void)setUserID:(NSString *)userID{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:userID forKey:PP_Userdefault_UserID];
}



-(void)setStoreSn:(NSString *)storeSn
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:storeSn forKey:PP_Userdefault_storeSn];
}

-(void)setLoginFlag:(NSString *)loginFlag
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:loginFlag forKey:PP_Userdefault_loginFlag];
}
-(void)setStoreFlag:(NSString *)storeFlag
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:storeFlag forKey:PP_Userdefault_storeFlag];
}

-(void)setOpenState_card:(NSString *)openState_card
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:openState_card forKey:PP_Userdefault_openState];

}
-(void)setCityLocationName:(NSString *)cityLocationName
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault setObject:cityLocationName forKey:PP_Userdefault_cityName];

}



-(NSString *)openState_card
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_openState];
}


-(NSString *)storeSn
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_storeSn];
}

-(NSString *)loginFlag
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_loginFlag];
}

-(NSString *)storeFlag
{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_storeFlag];
}


//获取
-(NSString*)user{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_User];
}
-(NSString*)pwd{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_Pwd];
}
- (NSString*)userID{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_UserID];
}

-(NSString *)token
{
    
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    return [userDefault textValueForKey:PP_Userdefault_UserToken];

}

-(NSString *)cityLocationName
{
    
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    NSString *cityName=[userDefault textValueForKey:PP_Userdefault_cityName];
    return kStringIsEmpty(cityName)?@"深圳市":cityName;
    
}


-(void)SynAllUserInfo:(PPUserModel *)model
{
    [USER_SYN setToken:model.token];
    [USER_SYN setUserID:model.boosId];
    [USER_SYN setUser:model.mobile];
    [USER_SYN setOpenState_card:model.cardOpenState];
    [USER_SYN setStoreSn:model.storeSn];
    [USER_SYN setLoginFlag:model.loginFlag];
    [USER_SYN setStoreFlag:model.storeFlag];
    

    
}


- (void)removeAllUserInfo{
    PPUserDefault *userDefault = [PPUserDefault sharedWXUserDefault];
    [userDefault removeObjectForKey:PP_Userdefault_UserID];
    [userDefault removeObjectForKey:PP_Userdefault_UserToken];
    [userDefault removeObjectForKey:PP_Userdefault_NewUserID];
    [userDefault removeObjectForKey:PP_Userdefault_User];
    [userDefault removeObjectForKey:PP_Userdefault_Pwd];
    [userDefault removeObjectForKey:PP_Userdefault_openState];
    [userDefault removeObjectForKey:PP_Userdefault_cityName];
    [userDefault removeObjectForKey:PP_Userdefault_storeSn];
    [userDefault removeObjectForKey:PP_Userdefault_loginFlag];
    [userDefault removeObjectForKey:PP_Userdefault_storeFlag];

}


@end
