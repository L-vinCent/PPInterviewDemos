//
//  shareView.h
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/6/7.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^shareBtnClick)(NSInteger tag);
@interface shareView : UIView

@property(nonatomic,copy)shareBtnClick btnClickBlock;
@end
