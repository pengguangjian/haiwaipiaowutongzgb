//
//  GetOnOffListVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "GetOnOffListVC.h"
#import "GetOnOffObj.h"
#import "GetOnOffListCell.h"

@interface GetOnOffListVC ()
{
    NSArray *dataArr;
}
@end

@implementation GetOnOffListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = _titleStr;
    
    [self initWithRefreshTableView:CGRectMake(0, SafeAreaTopHeight, DEVICE_Width, DEVICE_Height-SafeAreaTopHeight)];
        
//    self.tableView.mj_header = nil;
        //    self.tableView.mj_footer = nil;
    //    self.tableView.isShowWithoutDataView = YES;
        //    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 0.0001f)];
        //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 0.0001f)];
        
    self.tableView.separatorColor = SEPARATORCOLOR;
    
    [self getSeatList:_trip_id];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)leftBtnOnTouch:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getSeatList:(NSString*)tripid {
    
//    [SVProgressHUD showWithStatus:@"加载中"];
    [self.tableView headerBeginRefreshing];
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
        
        if ([rd.code isEqualToString:SUCCESS]) {
            
            NSArray *arr = nil;
            
            if ([_titleStr isEqualToString:@"请选择上车点"]) {
                arr = [rd.data valueForKey:@"pickup_points"];
            } else {
                arr = [rd.data valueForKey:@"drop_off_points_at_arrive"];
            }
            
            dataArr = [GetOnOffObj mj_objectArrayWithKeyValuesArray:arr];
            [self.tableView headerEndRefreshing];
            [self endFooterRefreshingWithNoMoreData];

            
            [self.tableView reloadData];
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:rd.msg];
            });
        }
    };
    
    NSDictionary *dic = @{@"trip_code":tripid};
    [hm getRequetInterfaceData:dic withInterfaceName:@"/api/ticket/seatmap"];
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
//    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"GetOnOffListCell";
    
    GetOnOffListCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (!cell)
    {
        UINib *nib = [UINib nibWithNibName:CustomCellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        cell = (GetOnOffListCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    }
    
    cell.textLabel.textColor = COL1;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.detailTextLabel.textColor = COL2;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    
    GetOnOffObj *gooo = [dataArr objectAtIndex:indexPath.row];
    
    NSArray *componds = [gooo.real_time componentsSeparatedByString:@" "];
    
    cell.timeLabel.text = [componds firstObject];
    cell.nameLabel.text = gooo.name;
    cell.addrLabel.text = gooo.address;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GetOnOffObj *gooo = [dataArr objectAtIndex:indexPath.row];
    
    if (self.getONHandler) {
        self.getONHandler(gooo);
    }
    if (self.getOffHander) {
        self.getOffHander(gooo);
    }
    [self leftBtnOnTouch:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}


#pragma mark - 设置 tableViewcell横线左对齐
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



@end
