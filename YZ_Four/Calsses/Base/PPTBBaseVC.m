//
//  PPTBBaseVC.m
//  amezMall_New
//
//  Created by Liao PanPan on 2017/11/3.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPTBBaseVC.h"
#import "UIScrollView+EmptyDataSet.h"

@interface PPTBBaseVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,copy)pullDownBlock downpullBlock;
@property(nonatomic,copy)pullUpBlock up_pullBlock;
@property(nonatomic,strong)MJRefreshNormalHeader* header;

@end

@implementation PPTBBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.noWifiDisplay=NO;
        self.noDataDisplay=NO;
        self.isNeedPullDownToRefreshAction = NO;
        self.isNeedPullUpToRefreshAction = NO;
        self.tableViewStyle=UITableViewStylePlain;
    }
    return self;
}

#pragma mark - 上拉加载和下拉刷新
- (void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable {
    
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    
    _isNeedPullDownToRefreshAction = isEnable;
    
    self.tableView.mj_header=self.header;
    
    
}

-(void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    
    _isNeedPullUpToRefreshAction = isEnable;
    
    self.tableView.mj_footer=self.footer;
    
}


-(void)TB_pullDownToRefreshAction:(pullDownBlock)block
{
    self.downpullBlock = block;
    
}

-(void)TB_pullUpToRefreshAction:(pullUpBlock)block
{
    self.up_pullBlock = block;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)stopRefreshingAnimation {
    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
    if ([self.footer isRefreshing]) {
        
        [self.footer endRefreshing];
    }
}


- (void)triggerRefreshing {
    
    [self.header beginRefreshing];
}

- (void)createTableView {
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH,SCREEN_HEIGHT-kDoorNavStatusHeight) style:self.tableViewStyle];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = Door_BGGray_color;
        
        self.tableView.separatorColor = RGB(216, 216, 216);
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate=self;
        
        [self.view addSubview:self.tableView];
        
    }
}

-(void)pullDownToRefresh_TB
{
    
    if (self.isNeedPullDownToRefreshAction&&self.downpullBlock) {
        
        self.downpullBlock();
    }
}

-(void)pullUPToRefresh_TB
{
    if (self.isNeedPullUpToRefreshAction&&self.up_pullBlock) {
        
        self.up_pullBlock();
    }
}

- (MJRefreshNormalHeader *)header{
    
    if (_header == nil) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToRefresh_TB)];
        //        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc]init];
//        MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUPToRefresh_TB)];
        
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.textColor = Door_TitleGray_color;
        //        header.stateLabel.hidden=YES;
        
//        header.loadingViewColor = Door_TitleGray_color;
        header.stateLabel.font = [UIFont systemFontOfSize:13];
        
        _header = header;
    }
    
    return _header;
}

- (MJRefreshAutoNormalFooter *)footer{

    if (_footer == nil) {

         MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUPToRefresh_TB)];

        footer.automaticallyChangeAlpha = YES;
        
//        header.automaticallyChangeAlpha = YES;
//        header.lastUpdatedTimeLabel.hidden = YES;
//        header.stateLabel.textColor = WPGlobalRefreshColor;
//        //        header.stateLabel.hidden=YES;
//
//        header.loadingViewColor = WPGlobalRefreshColor;
//        header.stateLabel.font = [UIFont systemFontOfSize:13];

        _footer = footer;
    }

    return _footer;
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = kStringIsEmpty(self.emptyTitle)?@"暂无数据":self.emptyTitle;
    if(self.noWifiDisplay) text=@"网络貌似链接不上了";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    
    return -30;
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 30;
}
-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    
    return self.noWifiDisplay||self.noDataDisplay;
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    //
    
    if(self.noDataDisplay) return [UIImage imageNamed:@"empty_icon"];
    
    if(self.noWifiDisplay) return [UIImage imageNamed:@"net_noWifi"];
    
    return [UIImage imageNamed:@""];
}




@end
