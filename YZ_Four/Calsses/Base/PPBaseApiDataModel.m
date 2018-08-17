//
//  PPBaseApiDataModel.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPBaseApiDataModel.h"

@implementation PPBaseApiDataModel

+(PPBaseApiDataModel *)getGlobalModel:(NSDictionary *)dic
{
    
    PPBaseApiDataModel *model=[PPBaseApiDataModel mj_objectWithKeyValues:dic];
    return model;
    
}


@end
