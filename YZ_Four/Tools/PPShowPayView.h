//
//  PPShowPayView.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/5/23.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPShowPayView : UIView

- (instancetype)initWithDelListView:(UIView *)view frame:(CGRect)frame;

-(void)showWithHeight:(CGFloat )height;
-(void)exitClick;
@property(nonatomic,strong)UILabel *moneylabel;

@end
