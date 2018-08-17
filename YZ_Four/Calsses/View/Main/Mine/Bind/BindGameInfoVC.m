//
//  BindGameInfoVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/8/9.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "BindGameInfoVC.h"
#import "PPBindMainView.h"
#import "PPVerifyUserVC.h"
#import "PPLOLAreaModel.h"
#import "ZJPickerView.h"
#import "PPVerifyUserVIew.h"
#import "LewPopupViewController.h"

@interface BindGameInfoVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *areaPickerView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)PPLOLAreaModel *selectModel;
@property(nonatomic,strong)PPBindMainView *bindView;
@property(nonatomic,strong)PPVerifyUserVIew *userView;

@end

@implementation BindGameInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItem.title = @"账户绑定";
    self.modelArray = @[].mutableCopy;
    self.titleArray = @[].mutableCopy;
    _bindView= [[[NSBundle mainBundle]loadNibNamed:@"PPBindMainView" owner:self options:0]lastObject];
    _bindView.frame = self.view.bounds;
    [self.view addSubview:_bindView];
    
    
    [_bindView.chooseAreaBtn addTarget:self action:@selector(showAreaChooseList) forControlEvents:UIControlEventTouchUpInside];
    [_bindView.BindBtn addTarget:self action:@selector(applyBind) forControlEvents:UIControlEventTouchUpInside];
    


    
    [self getLoLAreaList];
    
}

-(void)showVerify
{
    
    [self lew_presentPopupView:self.userView animation:[LewPopupViewAnimationFade new] dismissed:^{
        
        NSLog(@"动画结束");
        
    }];
    
    
}

-(PPVerifyUserVIew *)userView
{
    if (!_userView) {
        
        _userView= [[[NSBundle mainBundle]loadNibNamed:@"PPVerifyUserVIew" owner:self options:0]lastObject];
        _userView.frame = CGRectMake(0, 0, 300, 300);
    }
    return _userView;
}



-(UIPickerView *)areaPickerView
{
    if (!_areaPickerView) {
        
        _areaPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 300)];
        _areaPickerView.dataSource =self;
        _areaPickerView.delegate = self;
        
    }
    return _areaPickerView;
}

-(void)pushToVerify
{
    PPVerifyUserVC *vc = [[PPVerifyUserVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showAreaChooseList
{
    
    [self.view endEditing:YES];
    
    NSDictionary *propertyDict = @{ZJPickerViewPropertyCanceBtnTitleKey : @"取消",
                                   ZJPickerViewPropertySureBtnTitleKey  : @"确定"};

    kWeakSelf(self);
    
    [ZJPickerView zj_showWithDataList:self.titleArray propertyDict:propertyDict completion:^(NSString * _Nullable selectContent) {
        kStrongSelf(self);
        
        [self.bindView.chooseAreaBtn setTitle:selectContent forState:UIControlStateNormal];
        NSMutableString *str = selectContent.mutableCopy;
        NSString *areaName = [[str componentsSeparatedByString:@" "]lastObject];
        
        for (PPLOLAreaModel *model in self.modelArray) {
            
            if ([model.areaName isEqualToString:areaName]) {
                self.selectModel = model;
            }
        }
        
    }];
    
}

-(void)applyBind
{
    
    NSString *name = self.bindView.areaNameFiled.text;
    if (kStringIsEmpty(name)) {
        
        [PPHUDHelp showMessage:@"请输入游戏昵称"];
        return;
        
    }
    if (kObjectIsEmpty(self.selectModel)) {
        
        [PPHUDHelp showMessage:@"请选择游戏大区"];
        return;
    }
    LOADING_SHOW
    NSDictionary *dic = @{
                          @"areaId":self.selectModel.areaId,
                          @"userName":self.bindView.areaNameFiled.text,
                          };
    
    [HYBNetworking postWithUrl:Bind_User bodyDict:dic success:^(NSDictionary *response) {
        LOADING_HIDE
        PPBaseApiDataModel *model = [PPBaseApiDataModel getGlobalModel:response];
        if (code_success(model.code)) {
            
            //verificationTime   imageUrl
            NSLog(@"%@",model.data);
            
            [self showVerify];
            
            
        }else
        {
            
            [PPHUDHelp showMessage:model.message];
            
        }
        
    } failure:^(NSError *error) {
        
        LoADING_FAIL
    }];
    
}


-(void)getLoLAreaList
{
    
    LOADING_SHOW
    [HYBNetworking getWithUrl:Bind_LoLAreaList refreshCache:NO success:^(id response) {
        
        LOADING_HIDE
        PPBaseApiDataModel *model = [PPBaseApiDataModel getGlobalModel:response];

        if (code_success(model.code)) {
            NSArray *areaArray = (NSArray *)model.data;
            NSMutableArray *tempArr = @[].mutableCopy;
            NSMutableArray *tempTitleArr = @[].mutableCopy;
            for (NSDictionary *dic in areaArray) {
                
                PPLOLAreaModel *areaModel =[PPLOLAreaModel mj_objectWithKeyValues:dic];
                NSString *infoStr = [NSString stringWithFormat:@"%@  %@",areaModel.areaSimpleName,areaModel.areaName];
                [tempTitleArr addObject:infoStr];
                [tempArr addObject:areaModel];
                
            }
            self.modelArray = tempArr;
            self.titleArray = tempTitleArr;
            
//            [self.view addSubview:self.areaPickerView];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
