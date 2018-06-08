//
//  PPGlobaBottomBar.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/4/29.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBMBarBlockName)(NSInteger tag);

@interface PPGlobaBottomBar : UIView
- (instancetype)initWithFrame:(CGRect)frame countArray:(NSArray *)array;

-(void)clickBMBarBlock:(clickBMBarBlockName )block;

-(void)setSpecialBtnAtIndex:(NSInteger)index;

@end
