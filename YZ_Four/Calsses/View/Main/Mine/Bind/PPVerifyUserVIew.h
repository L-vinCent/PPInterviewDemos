//
//  PPVerifyUserVIew.h
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^verifyBlock)(void);

@interface PPVerifyUserVIew : UIView
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property(nonatomic,copy)verifyBlock verifyBlock;
@property (weak, nonatomic) IBOutlet UIImageView *verifyImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageV;

@end
