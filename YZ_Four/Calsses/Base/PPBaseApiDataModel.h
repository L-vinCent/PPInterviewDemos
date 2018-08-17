//
//  PPBaseApiDataModel.h
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBaseApiDataModel : NSObject

@property(nonatomic,strong)id data;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *code;

+(PPBaseApiDataModel *)getGlobalModel:(NSDictionary *)dic;

@end
