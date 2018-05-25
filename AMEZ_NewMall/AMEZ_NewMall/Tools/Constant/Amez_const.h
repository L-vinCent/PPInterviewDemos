//
//  Amez_const.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/5.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#ifndef Amez_const_h
#define Amez_const_h


//-----------------------------------------常用缩写------------------------------------------

#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults      [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

#define WPWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define WPStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define WEAK  @weakify(self);
#define STRONG  @strongify(self);

#define XNFont(font) [UIFont systemFontOfSize:(font)]
#define XNColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define LOADING_SHOW  [PPHUDHelp showLoading];
#define LOADING_HIDE  [PPHUDHelp hide];
#define LoADING_FAIL  [PPHUDHelp showMsgWithImage:@"抱歉，出错了噢" imageName:@"fail"];
#define USER_SYN [PPUserOBJ sharedUserOBJ]  //用户

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define WPLog(format,...) fprintf(stderr,"[类名:%s]:[行号:%d][函数名:%s]\t\n[内容:%s]\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__FUNCTION__,[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#define WPLog(format,...)
#endif

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;



#define DeviceIsiPhone5()				([[UIScreen mainScreen] bounds].size.height == 568.0)

#define DeviceIsSmallScreen()           ([[UIScreen mainScreen] bounds].size.width == 320.0)

#define DeviceIsiPhoneX()               ([[UIScreen mainScreen] bounds].size.height == 812.0)
// 屏幕宽高及常用尺寸

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define Ipad_Device [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define kDoorStatusBarHeight (DeviceIsiPhoneX() ? (44.0) : (20.0))
#define kDoorTabBarHeight (DeviceIsiPhoneX() ? (83.0) : (49.0))
#define kDoorNavStatusHeight (DeviceIsiPhoneX() ? (88.0) : (64.0))

#define NavigationBar_HEIGHT 44.0f
#define TabBar_HEIGHT kDoorTabBarHeight
#define StatusBar_HEIGHT kDoorStatusBarHeight
#define ToolsBar_HEIGHT 44.0f

#define Bottom_FitHEIGHT 50.0f


#define DoorFixScale 0.5
//rgb颜色转换（16进制->10进制）
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define Door_line_color RGB(34,34,34)   //线条色

#define Door_Global_title  RGB(255,199,60)  //主题色

#define Door_BGGlobal_color RGB(253,87,141) //主题背景色
//#define Door_BGGlobal_color WPHexColorA(0xfd578d,0)


#define Door_BtnGray_color RGB(143,146,161) //按钮背景色_灰

#define Door_TitleGray_color RGB(102,102,102) //灰字体

#define Door_Tabbar_color  RGB(242,203,129)  //tabbar标题颜色

#define Door_BGWhite_color RGB(255,255,255)  //背景白

#define WPHexColorA(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:(a)]
// 通知

#define POST_NOTIFY(__NAME, __OBJ, __INFO) [[NSNotificationCenter defaultCenter] postNotificationName:__NAME object:__OBJ userInfo:__INFO];

#define LISTEN_NOTIFY(__NAME, __OBSERVER, __SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:__OBSERVER selector:__SELECTOR name:__NAME object:nil];

#define REMOVE_NOTIFY(__OBSERVER) [[NSNotificationCenter defaultCenter] removeObserver:__OBSERVER];


//容错处理宏
 #define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define kDealNilString(str) kStringIsEmpty(str)?@"":str

#define kDealNilObj(obj) kObjectIsEmpty(obj)?@"":obj




#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// 系统版本

#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? 1 : 0


#define kLoginStatus @"login_status" //登录状态


//NSUserDefaults 实例化
/**  以key,value存储信息 */
#define USERDEFAULT_SET(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
/** 以key取出value */
#define USERDEFAULT_get(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
/** 以key删除value */
#define USERDEFAULT_MOVE(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
/** 立即同步 */
#define USERDEFAULT_SYNCHRONIZE  [[NSUserDefaults standardUserDefaults] synchronize]

#define STR_EQUAL(str1,str2) [str1 isEqualToString:str2]



#endif /* Amez_const_h */
