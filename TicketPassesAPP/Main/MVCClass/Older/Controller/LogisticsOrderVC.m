


//
//  LogisticsOrderVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/15.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "LogisticsOrderVC.h"
#import "LogisticsOrderCell.h"
#import "UIScrollView+XBRefresh.h"
#import "LogisticsOrderModel.h"
#import "OlderDateilsVC.h"
#import "LogisticsOrderRefundVC.h"

@interface LogisticsOrderVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
    
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LogisticsOrderVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_tableView){
        [self.tableView headerBeginRefreshing];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    WEAK_SELF;
    [self.tableView tableViewPullDown:^{

        [weakSelf requestLogisticslist];
        
    } ];
    [self.tableView headerBeginRefreshing];
}
   
#pragma mark ----  nelkeng
- (void)requestLogisticslist{
    WEAK_SELF;
    [AFHTTP requestLogisticslistOl_status:self.logisticsType success:^(NSDictionary *dic){
        
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.dataArray removeAllObjects];
        NSArray *addressdatas = dic[@"datas"];
        if([addressdatas isKindOfClass:[NSArray class]]){
            [weakSelf.dataArray addObjectsFromArray:addressdatas];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error){
        
        [weakSelf.tableView headerEndRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LogisticsOrderCell";
    LogisticsOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell= [[[NSBundle  mainBundle]  loadNibNamed:@"LogisticsOrderCell" owner:self options:nil]  lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WEAK_SELF;
    [cell setConfirmRefundNoticeViewBloak:^(LogisticsOrderModel *model){
        
        if (model.ol_status == 2) {
            [weakSelf goOrderRefundVC:model];
        } else {
            [weakSelf goOlderDateilsVC:model];
        }
        
        
    }];
    
    LogisticsOrderModel *model = [LogisticsOrderModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 114;
}
- (void)goOlderDateilsVC:(LogisticsOrderModel *)model{

    OlderDateilsVC *vc = [[OlderDateilsVC alloc]init];
    vc.order_id = model.ol_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)goOrderRefundVC:(LogisticsOrderModel *)model{

    LogisticsOrderRefundVC *vc = [[LogisticsOrderRefundVC alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark -- DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView  *)scrollView {
    return true;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView  *)scrollView
{
    if ([XBUtils networkEnable]) {
        return [UIImage imageNamed:@"img_blank"];;
    }else {
        return [UIImage imageNamed:@"img_nonetwork"];
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self.tableView headerBeginRefreshing];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_ALLDUD -50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromHex(0xf6f6f6);
    }
    return _tableView;
}


@end
