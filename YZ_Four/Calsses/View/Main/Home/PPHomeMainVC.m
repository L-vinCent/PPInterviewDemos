//
//  PPHomeMainVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/4.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPHomeMainVC.h"
#import "PPHomeMainCell.h"
#import "PPHomeDetailVC.h"
static NSString * const kCellIdentify_PPHomeMainCell= @"kCellIdentify_PPHomeMainCell";

@interface PPHomeMainVC ()

@end

@implementation PPHomeMainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
 
    
    self.navItem.title = @"首页";
    [self hiddenLeftBarItem:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PPHomeMainCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPHomeMainCell];

//    self.isNeedPullDownToRefreshAction =YES;
//    self.isNeedPullUpToRefreshAction = YES;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor clearColor];
    
    
//    [self triggerRefreshing];
    
    [self TB_pullDownToRefreshAction:^{
//
//        [self.dataArray removeAllObjects];
//        self.page = 1;
//        self.footer.state = MJRefreshStateIdle;
//        [self  getData_H5JPListInfo:self.page];
        
    }];
    
    [self TB_pullUpToRefreshAction:^{
        
//        self.page ++;
//        [self  getData_H5JPListInfo:self.page];
        
    }];
    
}

-(void)freshData_BSYVipList
{
//    [self.dataArray removeAllObjects];
//    self.page = 1;
//    self.footer.state = MJRefreshStateIdle;
//    [self  getData_H5JPListInfo:self.page];
}

-(void)freshPullData:(NSInteger )index
{
    
    
}

//-(void)getData_H5JPListInfo:(NSInteger)index
//{
//    NSString *page = [NSString stringWithFormat:@"%ld",(long)index];
//    NSMutableDictionary *dic = @{}.mutableCopy;
//    [dic setObject:USER_SYN.lastStoreId forKey:@"storeId"];
//    [dic setObject:@"4" forKey:@"orderState"];
//    [dic setObject:page forKey:@"currentPage"];
//    [dic setObject:@"20" forKey:@"showCount"];
//
//
//
//
//    [HYBNetworking postWithUrl:BSY_VipList  refreshCache:NO params:dic success:^(id response) {
//
//        PPBaseApiDataModel *model=[PPBaseApiDataModel mj_objectWithKeyValues:response];
//
//        PPJPH5Model *qdModel = [PPJPH5Model mj_objectWithKeyValues:model.datas];
//
//        NSArray *dataArr = qdModel.result;
//
//        if ([qdModel.next isEqualToString:@"0"]&&self.page!=1) {
//
//            [self stopRefreshingAnimation];
//            self.footer.state = MJRefreshStateNoMoreData;
//
//            return ;
//        }
//
//        if (STR_EQUAL(model.code, @"200")) {
//            //            LOADING_HIDE
//            for (NSDictionary *modelDic in dataArr) {
//
//                PPMemberInfoItem *infoItem = [PPMemberInfoItem mj_objectWithKeyValues:modelDic];
//                [self.dataArray addObject:infoItem];
//
//            }
//            if (!self.dataArray.count) {
//
//                self.noDataDisplay = YES;
//            }
//            [self.tableView reloadData];
//            //刷新列表
//
//        }else
//        {
//            [PPHUDHelp showMessage:model.msg];
//        }
//
//        [self stopRefreshingAnimation];
//
//    } fail:^(NSError *error) {
//
//        //        LoADING_FAIL
//        [self stopRefreshingAnimation];
//        self.noWifiDisplay = YES;
//        [self.tableView reloadData];
//    }];
//
//}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 30;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 158;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    PPHomeDetailVC *vc = [[PPHomeDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //精品模块
    PPHomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPHomeMainCell forIndexPath:indexPath];
  
    return cell;
    
}



@end
