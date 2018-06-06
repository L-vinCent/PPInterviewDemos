//
//  NSString+PPValidStr.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "NSString+PPValidStr.h"

@implementation NSString (PPValidStr)

- (BOOL)isValidateMobile{
    //手机号以13、15、18开头，八个\d数字字符
    
//    NSString *testStr = @"   aaa   ";
//    //去空格和回车
//    //如果仅仅是去前后空格，用whitespaceCharacterSet
//    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//    testStr = [testStr stringByTrimmingCharactersInSet:set];
//    NSString *phoneRegex = @"^1(3[0-9]|4[579]|5[0-35-9]|7[1-35-8]|8[0-9]|70)\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSString *tempS = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    return [phoneTest evaluateWithObject:tempS];
    
    BOOL isValid = tempS.length == 11?YES:NO;  // 只判断11位
    return isValid;
}
//邮箱地址的正则表达式
- (BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
 
    return [emailTest evaluateWithObject:self];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:0
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

@end
