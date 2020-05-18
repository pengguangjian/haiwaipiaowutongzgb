
//
//  TicketOrderVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/15.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "TicketOrderVC.h"
#import "CellPendingOlder.h"
#import "CellCompleted.h"
#import "TicketConfirmCV.h"
#import "RefundNoticeView.h"
#import "PaymentWebViewController.h"
#import "SelectPayTypeVC.h"

@interface TicketOrderVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RefundNoticeView *refundNoticeView;

@end

@implementation TicketOrderVC

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
    self.refundNoticeView = [RefundNoticeView sharedSingleton];
    [self.refundNoticeView setConfirmRefundNoticeViewBloak:^(TicketOrderModel * _Nonnull model, NSString * _Nonnull shouming) {
        
       [weakSelf goTicketConfirm:model shouming:shouming];
    }];
   
    [self.tableView tableViewPullDown:^{
        
        [weakSelf bookinglist];
        
    }];
    [self.tableView headerBeginRefreshing];
}
- (void)goTicketConfirm:(TicketOrderModel *)model shouming:(NSString *)shoumg{
    
    TicketConfirmCV *vc = [[TicketConfirmCV alloc]init];
    vc.model = model;
    vc.shouming = shoumg;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)goPalyAndTukKuan:(TicketOrderModel *)model{
    if([model.ob_status intValue] == 1){
        //支付
//        PaymentWebViewController *vc = [[PaymentWebViewController alloc]init];
//        vc.order_id = model.ob_id;
//        vc.order_type = @"1";
//        [self.navigationController pushViewController:vc animated:YES];
        
        SelectPayTypeVC *vc = [[SelectPayTypeVC alloc] initWithNibName:@"SelectPayTypeVC" bundle:nil];
        vc.order_id = model.order_code;
        vc.order_type = @"1";
        vc.isFromTicket = YES;
        vc.isFromOrder = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        //待坐车
        [self.refundNoticeView showMenu:model];
    }
}

- (void)bookinglist{
    
    WEAK_SELF;
    [AFHTTP requestBookinglistOb_status:self.tickeType  success:^(NSDictionary *dic){
        
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.dataArray removeAllObjects];
        NSArray *addressdatas = dic[@"addressdatas"];
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
    
    if([self.tickeType isEqualToString:@"1"] ||
       [self.tickeType isEqualToString:@"2"] ){
        static NSString *identifier = @"CellPendingOlder";
        CellPendingOlder * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell= [[[NSBundle  mainBundle]  loadNibNamed:@"CellPendingOlder" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TicketOrderModel *model = [TicketOrderModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        cell.model = model;
        WEAK_SELF;
        [cell setSelectCellViewBloak:^(TicketOrderModel *model){
            [weakSelf goPalyAndTukKuan:model];
        }];
    
        return cell;
    }else{
        
        static NSString *identifier = @"CellCompleted";
        CellCompleted * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell= [[[NSBundle  mainBundle]  loadNibNamed:@"CellCompleted" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TicketOrderModel *model = [TicketOrderModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        cell.model = model;
        
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.tickeType isEqualToString:@"1"]||[self.tickeType isEqualToString:@"2"]){
        return UITableViewAutomaticDimension;
        
    }else{
        return 130;
    }
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

- (UITableView *)tableView{
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
