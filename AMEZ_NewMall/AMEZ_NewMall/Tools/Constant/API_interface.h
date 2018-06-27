//
//  API_interface.h
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/5/17.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#ifndef API_interface_h
#define API_interface_h
////
//#define Base_H5URL @"http://h5.amez999.com/" //H5正式服务器
//#define Third_WXPay @"https://gateway.amez999.com/mobile/user/pay/weixin/app" //支付正式环境
//#define Base_APIURL @"https://gateway.amez999.com/mobile/user/" //接口测试服务器



#define Base_H5URL @"http://mobile.test.amyun.cn/" //H5测试服务器
#define Third_WXPay @"http://test.amyun.cn:18121/pay/weixin/app" //支付测试环境
#define Base_APIURL @"http://api.amez999.com/mobile/user/" //接口测试服务器



//------------------------------------------------------------商城接口---------------------------------------------------------------------

#define Product_detail(productId) [NSString stringWithFormat:@"%@/goodsSkuListVoList/%@",Base_APIURL,productId] //产品详情
#define InvitePeople(storeId,productId) [NSString stringWithFormat:@"%@/ecardStation/shareImageByte/%@/%@",Base_APIURL,storeId,productId] //邀请好友

#define Third_WXAppid @"wxe6ab9ac49ee9fe48"

#endif /* API_interface_h */
