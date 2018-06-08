//
//  PPJWTMainHomeVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPJWTMainHomeVC.h"
#import "PPJWTMainHomeCell.h"
static NSString * const kCellIdentify_PPJWTMainHomeCell= @"kCellIdentify_PPJWTMainHomeCell";

@interface PPJWTMainHomeVC ()

@end





@implementation PPJWTMainHomeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self.navItem.title = @"奖武堂";
    [self hiddenLeftBarItem:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PPJWTMainHomeCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPJWTMainHomeCell];
    
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



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //精品模块
    PPJWTMainHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPJWTMainHomeCell forIndexPath:indexPath];
    
    return cell;
    
}



@end
