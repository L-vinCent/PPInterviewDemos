//
//  PPMineOrderVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/8.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPMineOrderVC.h"
#import "PPMineOrderCell.h"
#import "XTSegmentControl.h"


static NSString *const kCellIdentfy_PPMineOrderCell = @"kCellIdentfy_PPMineOrderCell";

@interface PPMineOrderVC ()

@property (strong, nonatomic) XTSegmentControl *mySegmentControl;
@property (strong, nonatomic) NSArray *titlesArray;

@property (strong, nonatomic) NSMutableArray *pageArray; //翻页数据，记录页面上拉到哪一个 page

@property (strong, nonatomic) NSMutableArray *allArray; //全部数据
@property (strong, nonatomic) NSMutableArray *proceedArray; //待付款数据
@property (strong, nonatomic) NSMutableArray *startArray; //待收货数据
@property (strong, nonatomic) NSMutableArray *endArray; //已完成数据
@property (strong, nonatomic) NSArray *sumArray; //总数据
//@property (assign, nonatomic) NSString *page;

@property (strong, nonatomic) NSString *selectedIndexStr; //选中的标签
@property (strong, nonatomic) NSMutableArray *selectedArray; //选中的数组
@end

@implementation PPMineOrderVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.navItem.title=@"我的订单";
    self.tableView.frame = CGRectMake(0, Open_Order_kTopY, SCREEN_WIDTH, SCREEN_HEIGHT-Open_Order_kTopY);
    [self.tableView registerNib:[UINib nibWithNibName:@"PPMineOrderCell" bundle:nil] forCellReuseIdentifier:kCellIdentfy_PPMineOrderCell];
    self.selectedIndexStr = @"0";
    [self event_deal];
    //    self.page = @"1";
   // self.isNeedPullDownToRefreshAction =YES;
   // self.isNeedPullUpToRefreshAction = YES;
    self.navItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(passEvent)];
    
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
   // [self triggerRefreshing];
    
    [self TB_pullDownToRefreshAction:^{
        
        
        //        self.page = @"1";
        //        NSString *page = @"1";
//        [self.pageArray replaceObjectAtIndex:self.selectedIndexStr.integerValue withObject:@"1"];
//        NSString *page = self.pageArray[self.selectedIndexStr.integerValue];
//        [self.selectedArray removeAllObjects];
//
//        self.footer.state = MJRefreshStateIdle;
//        [self  getYYQData:page status:self.selectedIndexStr];
        
    }];
    
    [self TB_pullUpToRefreshAction:^{
        
//        NSInteger page = [self.pageArray[self.selectedIndexStr.integerValue] integerValue];
//        page++;
//
//        NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
//
//        [self.pageArray replaceObjectAtIndex:self.selectedIndexStr.integerValue withObject:pageStr];
//
//        [self getYYQData:pageStr status:self.selectedIndexStr];
        
    }];
}


-(void)passEvent
{
    // TODO: 筛选功能,弹出下拉框
    
    
    
}

-(void)noti_verifyYYQList:(NSNotification*)noti
{
    
    for (NSMutableArray *array in self.sumArray) {
        [array removeAllObjects];
    }
    self.selectedIndexStr = @"0";
    
    [self.mySegmentControl selectIndex:self.selectedIndexStr.integerValue];
    
    [self triggerRefreshing];
    self.footer.state = MJRefreshStateIdle;
    
    
}



//-(void)getYYQData:(NSString *)indexStr status:(NSString *)status
//{
//    //状态 1已预约 2已使用 3已过期 （为空或0为全部）
//
//    self.selectedArray = self.sumArray[status.integerValue];
//
//    NSDictionary *Dic = @{@"page":indexStr,
//                          @"pageSize":@"20",
//                          @"status":status,
//                          };
//
//    //    LOADING_SHOW
//    [HYBNetworking getWithUrl:YYQ_ListInfo(USER_SYN.lastStoreId) refreshCache:NO params:Dic success:^(id response) {
//        //        LOADING_HIDE
//        PPBaseApiDataModel *model = [PPBaseApiDataModel mj_objectWithKeyValues:response];
//
//        BOOL isNext = [model.datas[@"next"] boolValue];
//        NSInteger totalPage = [model.datas[@"totalPage"] integerValue];
//        NSString *page = self.pageArray[self.selectedIndexStr.integerValue];
//
//
//        if (!isNext&&![page isEqualToString:@"1"]&&page.integerValue!=totalPage) {
//
//            [self stopRefreshingAnimation];
//            self.footer.state = MJRefreshStateNoMoreData;
//            return ;
//
//        }
//
//
//        if ([model.code isEqualToString:@"200"]) {
//
//
//            NSArray *dataArr = model.datas[@"result"];
//
//            //            if(kArrayIsEmpty(dataArr)){
//            //                [self stopRefreshingAnimation];
//            //                self.footer.state = MJRefreshStateNoMoreData;
//            //                self.noDataDisplay = YES;
//            //                [self.tableView reloadData];
//            //                return;
//            //
//            //            }
//
//            for (int i =0; i<dataArr.count; i++) {
//
//                NSDictionary *dataDic = dataArr[i];
//                PPOrderVerifyModel * model = [PPOrderVerifyModel mj_objectWithKeyValues:dataDic];
//                [self.selectedArray addObject:model];
//
//            }
//
//            if (!self.selectedArray.count) {
//
//                self.noDataDisplay = YES;
//                self.footer.state = MJRefreshStateNoMoreData;
//
//            }
//
//            [self stopRefreshingAnimation];
//            [self.tableView reloadData];
//
//
//        }else
//        {
//
//            [PPHUDHelp showMessage:model.msg afterDelayTime:1.5];
//
//        }
//
//
//
//    } fail:^(NSError *error) {
//
//        LoADING_FAIL
//        [self stopRefreshingAnimation];
//        self.noWifiDisplay = YES;
//        [self.tableView reloadData];
//
//    }];
//
//}

-(void)event_deal
{
    
    
    self.allArray = @[].mutableCopy;
    self.proceedArray=@[].mutableCopy;
    self.startArray=@[].mutableCopy;
    self.endArray=@[].mutableCopy;
    
    self.sumArray = @[
                      self.allArray,
                      self.proceedArray,
                      self.startArray,
                      self.endArray,
                      ];
    
    self.pageArray = @[@"1",@"1",@"1",@"1"].mutableCopy;
    
    
    self.selectedIndexStr = @"0";
    self.selectedArray=self.sumArray[0];  //默认为全部
    
    //    WEAK
    
    self.mySegmentControl = [[XTSegmentControl alloc] initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH, Open_Order_kMySegmentControl_Height) Items:self.titlesArray selectedBlock:^(NSInteger index) {
        
        //        STRONG
        self.selectedIndexStr=[NSString stringWithFormat:@"%ld",(long)index];
        //
        self.footer.state = MJRefreshStateIdle;
        
//        self.selectedArray = self.sumArray[self.selectedIndexStr.integerValue];
        //        //
        
//        if (kArrayIsEmpty(self.selectedArray)) {
//
//
//            [self.pageArray replaceObjectAtIndex:self.selectedIndexStr.integerValue withObject:@"1"];
//
//            [self getYYQData:@"1" status:self.selectedIndexStr];
//            [self.tableView reloadData];
//
//        }else
//        {
//            //有数据了就不请求接口
//            [self.tableView reloadData];
//        }
        
    }];
    
    [self.view addSubview:self.mySegmentControl];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
//    return self.selectedArray.count;
    return 10;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PPMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentfy_PPMineOrderCell forIndexPath:indexPath];
    
 
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return !section?0.1:10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    v.backgroundColor = Door_BGGray_color;
    return  v;
    
}

- (NSArray*)titlesArray
{
    if (nil == _titlesArray) {
        _titlesArray = @[@"全部", @"待付款", @"待收货",@"已完成",@"已取消"];
    }
    return _titlesArray;
}




@end
