//
//  webProgressLine.h
//  AMEZ_NewMall
//
//  Created by Liao PanPan on 2018/6/1.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webProgressLine : UIView

@property(nonatomic,strong)UIColor *lineColor;

-(void)startLoadingAnimation;

-(void)endLoadingAnimation;

@end
