//
//  API_interface.h
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#ifndef API_interface_h
#define API_interface_h

//#define Base_H5URL @"http://h5.amez999.com/" //正式服务器
//#define Base_H5URL @"http://mobile.test.amyun.cn/" //测试服务器


#define Base_H5URL @"http://47.106.119.24:8880/" //正式服务器


#define Login_smsCode(phone) [NSString stringWithFormat:@"common/sms/getSmsCode/?mobile=%@",phone] //获取验证码
#define Login_login @"member/login" //登录
#define Login_regist @"member/register" //注册

#define Bind_User @"member/bindGameInfo" //绑定用户
#define Bind_isSuccess @"member/checkBind" //校验 是否绑定成功
#define Bind_LoLAreaList @"common/getArea" //获取大区列表信息
#define Bind_specialCHaractar @"/common/getSpecialCharacter" //特殊字符列表


#define Third_WXAppid @"wxe6ab9ac49ee9fe48"
#define THird_WXAppsecret @"32bd5f82fc868ed84309c78a76b72430"





#endif /* API_interface_h */
