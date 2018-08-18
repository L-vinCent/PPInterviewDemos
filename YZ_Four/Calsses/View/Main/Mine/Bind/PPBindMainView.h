//
//  PPBindMainView.h
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^fuzhuClick)(NSString *character);

@interface PPBindMainView : UIView
@property (weak, nonatomic) IBOutlet UIButton *BindBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseAreaBtn;
@property (weak, nonatomic) IBOutlet UITextField *areaNameFiled;
@property (weak, nonatomic) IBOutlet UIView *fuzhuBGView;


-(void)loadFuZhuArrays:(NSArray *)fuzhuArr ClickContents:(fuzhuClick)clockBlock;
@end
