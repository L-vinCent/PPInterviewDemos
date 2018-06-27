//
//  PPHomeDetailVC.m
//  YZ_Four
//
//  Created by Liao PanPan on 2018/6/6.
//  Copyright © 2018年 Liao PanPan. All rights reserved.
//

#import "PPHomeDetailVC.h"
#import "PPHomeMainCell.h"
#import "PPDetailTypeOneCell.h"
#import "PPDetailTwoCell.h"
#import "PPDetailThreeCell.h"
#import "PPGlobaBottomBar.h"
static NSString * const kCellIdentify_PPDetailTypeOneCell= @"kCellIdentify_PPDetailTypeOneCell";
static NSString * const kCellIdentify_PPDetailTwoCell= @"kCellIdentify_PPDetailTwoCell";
static NSString * const kCellIdentify_PPDetailThreeCell= @"kCellIdentify_PPDetailThreeCell";

const CGFloat ZYTopViewH = 150;
const CGFloat sectionHeadViewH = 40;

@interface PPHomeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)UIView *segmentHeadView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *titlesArray;

@property(nonatomic,assign)NSInteger type; //0 规则  1 奖品   2 排行榜

@end

@implementation PPHomeDetailVC

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    self.type = 0;
//    self.tableViewStyle = UITableViewStyleGrouped;
    [self createTableView];
    [self.navigationBar setHidden:YES];
    self.tableView.PP_height -=TabBar_HEIGHT;
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailTypeOneCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailTypeOneCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailTwoCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailTwoCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailThreeCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailThreeCell];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(ZYTopViewH , 0, 0, 0);
    
    UIImage *scaleImage = [self image:[UIImage imageNamed:@"yz"] byScalingToSize:CGSizeMake(SCREEN_WIDTH, ZYTopViewH)];
    UIImageView *topView = [[UIImageView alloc]initWithImage:scaleImage];
    topView.frame = CGRectMake(0, -ZYTopViewH, SCREEN_WIDTH, ZYTopViewH);

    UIButton *btn = [UIButton cz_imageButton:@"navigationbar_back_withtext_highlighted" backgroundImageName:@""];
    [btn addTarget:self action:@selector(btnClick_detail) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 20, 45, 45);
    [self.view addSubview:btn];
    
    UILabel *label = [UILabel cz_labelWithText:@"详情" fontSize:18 color:[UIColor whiteColor]];
    label.frame = CGRectMake(0, 20,150 , 45);
    label.PP_centerX = self.view.PP_centerX;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;

    
    PPGlobaBottomBar *bar=  [[PPGlobaBottomBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TabBar_HEIGHT, SCREEN_WIDTH, TabBar_HEIGHT) countArray:@[@"122人已报名",@"立即报名"]];
    [bar setSpecialBtnAtIndex:2];
    [bar clickBMBarBlock:^(NSInteger tag) {
        
        
    }];
    
    [self.view addSubview:bar];
}

-(void)btnClick_detail
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView {
    if (!self.tableView) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = Door_BGGray_color;
        
        self.tableView.separatorColor = RGB(216, 216, 216);
        
        [self.view addSubview:self.tableView];
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return  self.segmentHeadView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *heightArr = @[@"448",@"320",@"50"];
    CGFloat height = [heightArr[self.type] floatValue];
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeadViewH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.type) {
        case 0:
        {
              return 1;
        }
            break;
        
        case 1:
        {
              return 1;
        }
            break;
            
        case 2:
        {
            return 20;
        }
            break;
            
        default:
            break;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.type) {
        
        PPDetailTypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPDetailTypeOneCell forIndexPath:indexPath];
        
        return cell;
        
    }else if(self.type ==1)
    {
        PPDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPDetailThreeCell forIndexPath:indexPath];
        
        return cell;
    }else
    {
        
        PPDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify_PPDetailTwoCell forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
        
    }
    
   
    
    
}

-(void)segmentChange:(UISegmentedControl*)sender
{
    
    self.type = sender.selectedSegmentIndex;
    [self.tableView reloadData];
    
//    if (sender.selectedSegmentIndex == 0) {
//        NSLog(@"1");
//    }else if (sender.selectedSegmentIndex == 1){
//        NSLog(@"2");
//    }else if (sender.selectedSegmentIndex == 2){
//        NSLog(@"3");
//    }
    
}

-(UIView *)segmentHeadView
{
    if(nil == _segmentHeadView)
    {
        _segmentHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionHeadViewH)];
        UISegmentedControl  *segment = [[UISegmentedControl alloc]initWithItems:self.titlesArray];
        segment.frame = _segmentHeadView.bounds;
        segment.selectedSegmentIndex = 0;
        [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        segment.tintColor = Door_title_color;
        
        // 去掉颜色,现在整个segment偶看不到,可以相应点击事件
        segment.tintColor = [UIColor clearColor];
        
        // 正常状态下
        NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName : Door_title_color};
        [segment setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
        
        // 选中状态下
        NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16.0f],NSForegroundColorAttributeName : Door_BGGlobal_color};
        [segment setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
        
        
        [_segmentHeadView addSubview:segment];
    }
    return _segmentHeadView;
}

- (NSArray*)titlesArray
{
    if (nil == _titlesArray) {
        _titlesArray = @[@"规则", @"奖品",@"排行榜"];
    }
    return _titlesArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat offsetH = -ZYTopViewH - offsetY;
    
    if (offsetH < 0) return;
    
    CGRect frame = self.topView.frame;
    frame.size.height = ZYTopViewH + offsetH;
    self.topView.frame = frame;
    self.topView.PP_origin = CGPointMake(0, -ZYTopViewH-offsetH);
    
}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self setStatusBarBackgroundColor:Door_BGGlobal_color];

}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}


@end
