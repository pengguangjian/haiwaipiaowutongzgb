//
//  BusCommentVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BusCommentVC.h"
#import "ServiceEvaluateCell.h"
#import "CommentObj.h"

@interface BusCommentVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) TYStarRateView *starRate;
@end

@implementation BusCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setWidth:DEVICE_Width];
    [self.view setHeight:DEVICE_Height-SafeAreaTopHeight-50];
        
        
    [self initWithRefreshTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-SafeAreaTopHeight-50)];
        
        //    self.tableView.mj_header = nil;
            //    self.tableView.mj_footer = nil;
        //    self.tableView.isShowWithoutDataView = YES;
            //    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 0.0001f)];
            //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 0.0001f)];
            
    //    self.tableView.separatorStyle = NO;
    self.tableView.separatorColor = SEPARATORCOLOR;
    
    [self createHeadView];
    
    [self loadFirstData];
}

- (void)loadFirstData {
    
    self.page = 1;
    _dataArray = [[NSMutableArray alloc] init];
    [self loadMoreData];
}

- (void)loadMoreData {

    WEAK_SELF;
    HttpManager *hm = [HttpManager createHttpManager];
    hm.responseHandler = ^(id responseObject) {

        dispatch_async(dispatch_get_main_queue(), ^{

            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];

            if ([rd.code isEqualToString:SUCCESS] ) {

                NSArray *dic = [rd.data valueForKey:@"items"];
                NSArray *tempArr  = [CommentObj mj_objectArrayWithKeyValuesArray:dic];
                
                NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:_dataArray];
                [mutableArray addObjectsFromArray:tempArr];
                _dataArray = [mutableArray mutableCopy];
                
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
                
                [self endHeaderRefreshing];
                [self endFooterRefreshing];
                
//                if (tempArr.count < ONE_PAGE) {
//                    // 变为没有更多数据的状态
                    [self endFooterRefreshingWithNoMoreData];
//                }
                self.page++;

            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });

    };

    NSDictionary *dataDic = @{@"company_id":_company_id};

    [hm getRequetInterfaceData:dataDic withInterfaceName:@"api/ticket/getcompanyreview"];

}


- (void)createHeadView {
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, DEVICE_Width, 190);
    headView.backgroundColor = [UIColor whiteColor];
    
    UIView *starContainerView = [[UIView alloc] init];
    starContainerView.frame = CGRectMake((DEVICE_Width-200)/2.0f, 15, 200, 40);
    starContainerView.backgroundColor = RGBA(86, 177, 87, 0.8);
    [headView addSubview:starContainerView];
    
    _starRate = [[TYStarRateView alloc] initWithFrame:CGRectMake(16+50, 0, 200-16-50-8, 40) numberOfStars:5];
    _starRate.scorePercent = 4.4/5.0;
    _starRate.allowIncompleteStar = NO;
    _starRate.hasAnimation = YES;
    _starRate.isSetting = NO;
    _starRate.delegate = self;
    [starContainerView addSubview:_starRate];
    
    UILabel *starLabel = [[UILabel alloc] init];
    starLabel.frame = CGRectMake(8, 0, 50, 40);
    starLabel.backgroundColor = [UIColor clearColor];
    starLabel.textColor = [UIColor whiteColor];
    starLabel.text = @"4.4/5.0";
    starLabel.textAlignment = NSTextAlignmentCenter;
    starLabel.font = [UIFont systemFontOfSize:14];
    [starContainerView addSubview:starLabel];
    
    UILabel *cancelTimeLabel = [[UILabel alloc] init];
    cancelTimeLabel.frame = CGRectMake(0, 58, DEVICE_Width, 30);
    cancelTimeLabel.backgroundColor = [UIColor clearColor];
    cancelTimeLabel.textColor = COL1;
    cancelTimeLabel.text = @"汽车总评分";
    cancelTimeLabel.textAlignment = NSTextAlignmentCenter;
    cancelTimeLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:cancelTimeLabel];
    
    float sliderWidth = DEVICE_Width-40-15 - 100 - 15 - 40;
    
    UILabel *busQualityLabel = [[UILabel alloc] init];
    busQualityLabel.frame = CGRectMake(15, 100, 100, 14);
    busQualityLabel.backgroundColor = [UIColor clearColor];
    busQualityLabel.textColor = COL1;
    busQualityLabel.text = @"汽车质量";
    busQualityLabel.textAlignment = NSTextAlignmentLeft;
    busQualityLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busQualityLabel];
    
    UIView *busQualitySliderView = [[UIView alloc] initWithFrame:CGRectMake(15+100 + 20, 100, sliderWidth*4.6/5.0, 15)];
    [busQualitySliderView setBackgroundColor:RGBA(86, 177, 87, 0.8)];
    [headView addSubview:busQualitySliderView];
    
    UILabel *busQualityValueLabel = [[UILabel alloc] init];
    busQualityValueLabel.frame = CGRectMake(DEVICE_Width-40-15, 100, 40, 14);
    busQualityValueLabel.backgroundColor = [UIColor clearColor];
    busQualityValueLabel.textColor = COL1;
    busQualityValueLabel.text = @"4.6";
    busQualityValueLabel.textAlignment = NSTextAlignmentRight;
    busQualityValueLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busQualityValueLabel];
    
    
    UILabel *busPunctuallyLabel = [[UILabel alloc] init];
    busPunctuallyLabel.frame = CGRectMake(15, 125, 100, 14);
    busPunctuallyLabel.backgroundColor = [UIColor clearColor];
    busPunctuallyLabel.textColor = COL1;
    busPunctuallyLabel.text = @"守时";
    busPunctuallyLabel.textAlignment = NSTextAlignmentLeft;
    busPunctuallyLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busPunctuallyLabel];
    
    UIView *busPunctuallySliderView = [[UIView alloc] initWithFrame:CGRectMake(15+100 + 20, 125, sliderWidth*3.9/5.0, 15)];
    [busPunctuallySliderView setBackgroundColor:RGBA(86, 177, 87, 0.8)];
    [headView addSubview:busPunctuallySliderView];
    
    UILabel *busPunctuallyValueLabel = [[UILabel alloc] init];
    busPunctuallyValueLabel.frame = CGRectMake(DEVICE_Width-40-15, 125, 40, 14);
    busPunctuallyValueLabel.backgroundColor = [UIColor clearColor];
    busPunctuallyValueLabel.textColor = COL1;
    busPunctuallyValueLabel.text = @"3.9";
    busPunctuallyValueLabel.textAlignment = NSTextAlignmentRight;
    busPunctuallyValueLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busPunctuallyValueLabel];
    
    UILabel *busServiceLabel = [[UILabel alloc] init];
    busServiceLabel.frame = CGRectMake(15, 150, 100, 14);
    busServiceLabel.backgroundColor = [UIColor clearColor];
    busServiceLabel.textColor = COL1;
    busServiceLabel.text = @"服务";
    busServiceLabel.textAlignment = NSTextAlignmentLeft;
    busServiceLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busServiceLabel];
    
    UIView *busServiceSliderView = [[UIView alloc] initWithFrame:CGRectMake(15+100 + 20, 150, sliderWidth*4.5/5.0, 15)];
    [busServiceSliderView setBackgroundColor:RGBA(86, 177, 87, 0.8)];
    [headView addSubview:busServiceSliderView];
    
    UILabel *busServiceValueLabel = [[UILabel alloc] init];
    busServiceValueLabel.frame = CGRectMake(DEVICE_Width-40-15, 150, 40, 14);
    busServiceValueLabel.backgroundColor = [UIColor clearColor];
    busServiceValueLabel.textColor = COL1;
    busServiceValueLabel.text = @"4.5";
    busServiceValueLabel.textAlignment = NSTextAlignmentRight;
    busServiceValueLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:busServiceValueLabel];
    
    
    self.tableView.tableHeaderView = headView;
    
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"ServiceEvaluateCell";
    ServiceEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (!cell)
    {
        UINib *nib = [UINib nibWithNibName:CustomCellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        cell = (ServiceEvaluateCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    }
    
    CommentObj *ci = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.nickNameLabel.text = ci.first_name;
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:[UIImage imageNamed:@"img_my_head"]];
    cell.dateLabel.text = [Util time_timesLocaleToString:ci.rating_date];
    cell.starRate.scorePercent = [ci.overall_rating floatValue]/5.0f;
    cell.contentLabel.text =  ci.comment;

    cell.technicianNameLabel.text = nil;
    
    CGSize textSize = [cell.contentLabel.text boundingRectWithSize:CGSizeMake(DEVICE_Width-85, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:cell.contentLabel.font}
                                         context:nil].size;
    
    [cell setHeight:110-15+textSize.height];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

/**
 *  分割线的处理
 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    
}



@end
