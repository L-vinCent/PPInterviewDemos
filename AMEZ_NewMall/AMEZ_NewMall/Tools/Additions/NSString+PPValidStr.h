//
//  NSString+PPValidStr.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PPValidStr)

- (BOOL)isValidateMobile;

- (BOOL)isValidateEmail;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+(NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month;

@end
