//
//  PPMineMainVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/7.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMineMainVC.h"
#import "PPMineMainCell.h"
#import "PPMainTopUserCell.h"
#import "PPLoginMainVC.h"
#import "PPNavViewController.h"
static NSString *const kCellIdentify_PPMineMainCell = @"kCellIdentify_PPMineMainCell";
static NSString *const kCellIdentify_PPMainTopUserCell = @"kCellIdentify_PPMainTopUserCell";

@interface PPMineMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation PPMineMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setupUI_door];
    
    self.navItem.title =@"";
    
    

  
    
}


-(void)setupUI_door
{
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-kDoorNavStatusHeight);
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = WPHexColorA(0xeeeeee, 1);
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellAccessoryDisclosureIndicator;
    [self.tableView registerNib:[UINib nibWithNibName:@"PPMineMainCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPMineMainCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPMainTopUserCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPMainTopUserCell];

    
}

-(NSMutableArray *)dataArr
{
    if (kArrayIsEmpty(_dataArr)) {
        
        NSMutableArray *tempArray = @[
                                      
                                      @[
                                          @{@"title":@"顶部视图",@"iconName":@" ",@"vcName":@""},
                                          
                                          ],
                                      
                                      @[
                                          @{@"title":@"绑定游戏账户",@"iconName":@" ",@"vcName":@"BindGameInfoVC"},
                                          
                                          ],
                                      @[
                                          @{@"title":@"获奖记录",@"iconName":@"set_TQ",@"vcName":@"PPMineRecordVC"},
                                          ],
                                      @[
                                          @{@"title":@"领奖信息",@"iconName":@"home_account",@"vcName":@""},
                                          
                                          ],
                                      @[
                                          @{@"title":@"我的订单",@"iconName":@"home_account",@"vcName":@"PPMineOrderVC"},
                                          
                                          ],
                                      @[
                                          @{@"title":@"退出登录",@"iconName":@"home_account",@"vcName":@"123"},
                                          
                                          ],
                                      ].mutableCopy;
        _dataArr = tempArray.mutableCopy;
    }
  
    return _dataArr;
}

#pragma mark Table M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
     
            PPMainTopUserCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPMainTopUserCell forIndexPath:indexPath];


            return cell;
        
    }else{
        
        
        PPMineMainCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPMineMainCell forIndexPath:indexPath];

        NSDictionary *dic=_dataArr[indexPath.section][indexPath.row];
        cell.titleLael.text = dic[@"title"];
//        [cell setTitle:dic[@"title"] icon:dic[@"iconName"]];

        //        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
//        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0 hasSectionLine:NO];
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return !indexPath.section?213:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0/[UIScreen mainScreen].scale;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return   section?8:0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    headerView.backgroundColor = WPHexColorA(0xeeeeee,1.0) ;
    return headerView;
}

-(void)logout
{
    
    [USER_SYN removeAllUserInfo];
    [self goLoginVC];
    
}

-(void)goLoginVC
{
    PPLoginMainVC *vc=[[PPLoginMainVC alloc]init];
    PPNavViewController *nav=[[PPNavViewController alloc]initWithRootViewController:vc];
    [kKeyWindow setRootViewController:nav];
    [kKeyWindow makeKeyAndVisible];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className=_dataArr[indexPath.section][indexPath.row][@"vcName"];
    
    if (kStringIsEmpty(className))  return;
    
//    if (kStringIsEmpty(USER_SYN.token)) {
//
//        [PPHUDHelp showMessage:@"请先登录" afterDelayTime:1];
//        return;
//    }
    
    if ([className isEqualToString:@"123"]) {
        [self logout];
        return;
    }
    
    [self pushWithVCName:className];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillDisappear:(BOOL)animated
{

    [self setStatusBarBackgroundColor:Door_NavBar_color];

}
@end
