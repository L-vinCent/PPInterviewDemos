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
    self.navItem.title = @"详情";
    [self createTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailTypeOneCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailTypeOneCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailTwoCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailTwoCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PPDetailThreeCell" bundle:nil] forCellReuseIdentifier:kCellIdentify_PPDetailThreeCell];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(ZYTopViewH , 0, 0, 0);
    UIImage *scaleImage = [self image:[UIImage imageNamed:@"yz"] byScalingToSize:CGSizeMake(SCREEN_WIDTH, ZYTopViewH)];
    UIImageView *topView = [[UIImageView alloc]initWithImage:scaleImage];
    topView.frame = CGRectMake(0, -ZYTopViewH, SCREEN_WIDTH, ZYTopViewH);

    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;

}

- (void)createTableView {
    if (!self.tableView) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kDoorNavStatusHeight, SCREEN_WIDTH,SCREEN_HEIGHT-kDoorNavStatusHeight) style:UITableViewStyleGrouped];
        
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


@end
