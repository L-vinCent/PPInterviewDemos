//
//  PPUserDefault.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/9.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPUserdefaultDefine.h"

@interface PPUserDefault : NSObject

+ (id)sharedWXUserDefault;

- (NSInteger)integerValueForKey:(NSString*)key;
- (BOOL)boolValueForKey:(NSString*)key;
- (NSString*)textValueForKey:(NSString*)key;
- (NSDictionary*)dicValueForKey:(NSString*)key;
- (CGFloat)floatValueForKey:(NSString*)key;
- (void)setInteger:(NSInteger)value forKey:(NSString*)key;
- (void)setBool:(BOOL)value forKey:(NSString*)key;
- (void)setFloat:(float)value forkey:(NSString*)key;
- (void)setObject:(id)object forKey:(NSString*)key;

- (void)removeObjectForKey:(NSString*)key;
- (NSArray*)allKeys;
- (BOOL)hasKey:(NSString*)key;


@end
