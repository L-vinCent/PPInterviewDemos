//
//  NSString+CZPath.h
//
//  Created by 刘凡 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^getQRCodeImage)(UIImage *codeImage);

@interface NSString (CZPath)

/// 给当前文件追加文档路径
- (NSString *)cz_appendDocumentDir;

/// 给当前文件追加缓存路径
- (NSString *)cz_appendCacheDir;

/// 给当前文件追加临时路径
- (NSString *)cz_appendTempDir;



- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

+(NSString *)transToTime:(NSString *)timsp;

-(UIImage *)stringToImage;


-(int)compareSelfToDate:(NSString*)date02;//比较日期字符串大小



- (void)creatCIQRCodeImageByStr:(getQRCodeImage)block; //生成二维码


//是数字或者小数
- (BOOL)isInputRuleAndNumber;

-(BOOL)validateMoney_decminal;

@end
