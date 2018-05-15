//
//  PPObserver.m
//  KVO_Test
//
//  Created by Liao PanPan on 2018/5/15.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPObserver.h"
#import "PPObject.h"

@implementation PPObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([object isKindOfClass:[PPObject class]] &&
        [keyPath isEqualToString:@"value"]) {
        
        // 获取value的新值
        NSNumber *valueNum = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"value is %@", valueNum);
    }
}


@end
