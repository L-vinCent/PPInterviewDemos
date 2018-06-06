//
//  PPJWTMainVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/6.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPJWTMainVC.h"
#import "PPJWTMainCell.h"
#import "PPJWTHeadVIew.h"
static NSString * const kCellIdentify_PPJWTMainCell= @"kCellIdentify_PPJWTMainCell";

@interface PPJWTMainVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PPJWTMainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navItem.title = @"详情";
    [self createTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPJWTMainCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPJWTMainCell];
    
}

- (void)createTableView {
    if (!self.tableView) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH,SCREEN_HEIGHT-kDoorNavStatusHeight) style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = Door_BGGray_color;
        
        self.tableView.separatorColor = RGB(216, 216, 216);
        
        [self.view addSubview:self.tableView];
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 57;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *new = [[[NSBundle mainBundle]loadNibNamed:@"PPJWTHeadVIew" owner:self options:0]lastObject];
    new.frame = CGRectMake(0, 0, SCREEN_WIDTH, 57);
    return  new;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        PPJWTMainCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPJWTMainCell forIndexPath:indexPath];
        return cell;

}




@end
