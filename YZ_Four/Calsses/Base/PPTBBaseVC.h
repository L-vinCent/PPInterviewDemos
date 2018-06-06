//
//  PPTBBaseVC.h
//  amezMall_New
//
//  Created by Liao PanPan on 2017/11/3.
//  Copyright © 2017年 Liao PanPan. All rights reserved.
//

#import "PPBaseViewController.h"
#import "MJRefresh.h"

typedef void(^pullDownBlock)(void);
typedef void(^pullUpBlock)(void);

@interface PPTBBaseVC : PPBaseViewController<UITableViewDelegate,UITableViewDataSource>

- (void)TB_pullDownToRefreshAction:(pullDownBlock)block;

// 上拉加载触发的方法

- (void)TB_pullUpToRefreshAction:(pullUpBlock)block;;

@property(nonatomic,strong)MJRefreshAutoNormalFooter* footer;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSString* emptyTitle; //为加载数据的时候不显示

@property (nonatomic, assign)  BOOL noDataDisplay; //为加载数据的时候不显示

@property (nonatomic, assign)  BOOL noWifiDisplay; //没网时候的显示

@property (nonatomic, assign) UITableViewStyle tableViewStyle; // 用来创建 tableView

@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;

@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

-(void)createTableView;

- (void)stopRefreshingAnimation;

- (void)triggerRefreshing;
@end
