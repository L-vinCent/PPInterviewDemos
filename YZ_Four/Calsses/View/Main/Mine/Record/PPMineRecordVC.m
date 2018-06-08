//
//  PPMineRecordVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMineRecordVC.h"
#import "PPMineRecordCell.h"

static NSString * const kCellIdentify_PPMineRecordCell= @"kCellIdentify_PPMineRecordCell";

@interface PPMineRecordVC ()

@end

@implementation PPMineRecordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self.navItem.title = @"获奖记录";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PPMineRecordCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPMineRecordCell];
    self.tableView.separatorColor = [UIColor clearColor];
    //    self.isNeedPullDownToRefreshAction =YES;
    //    self.isNeedPullUpToRefreshAction = YES;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
    
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
    
    return 30;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 93;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //精品模块
    PPMineRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPMineRecordCell forIndexPath:indexPath];
    
    return cell;
    
}



@end
