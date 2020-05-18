//
//  BackMoneyNoticeVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BackMoneyNoticeVC.h"
#import "BackMoneyRoleObj.h"
#import "RoleObj.h"

@interface BackMoneyNoticeVC ()
{
    NSArray *dataArr;
    BackMoneyRoleObj *bmro;
}
@end

@implementation BackMoneyNoticeVC

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
    
    
    
    [self getBackMoneyData];
}


- (void)getBackMoneyData {

    HttpManager *hm = [HttpManager createHttpManager];
    hm.responseHandler = ^(id responseObject) {

        dispatch_async(dispatch_get_main_queue(), ^{

            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];

            if ([rd.code isEqualToString:SUCCESS] ) {

                id arr = [[rd.data objectForKey:@"data"] objectForKey:@"detail"];
                    
                bmro = [BackMoneyRoleObj mj_objectWithKeyValues:[rd.data objectForKey:@"data"]];
                    
                dataArr = [RoleObj mj_objectArrayWithKeyValuesArray:arr];
                [self endFooterRefreshingWithNoMoreData];
                
                [self.tableView reloadData];
                
                [self createHeadView];
                
                [self createFooterView];

            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });

    };

    NSDictionary *dataDic = @{@"trip_code":_company_id};

    [hm getRequetInterfaceData:dataDic withInterfaceName:@"api/ticket/cancel"];

}


- (void)createFooterView {
    
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *headlabel = [[UILabel alloc] init];
    headlabel.frame = CGRectMake(15, 0, DEVICE_Width-15, 40);
    headlabel.backgroundColor = [UIColor clearColor];
    headlabel.textColor = UIColorFromHex(0x56B157);
    headlabel.text = @"温馨提示";
    headlabel.textAlignment = NSTextAlignmentLeft;
    headlabel.font = [UIFont systemFontOfSize:15];
    [footerView addSubview:headlabel];
    
    if (!(bmro.note.length>0)) {
        bmro.note = @"取消政策取决于运营商，并且会不时更改。有关更多信息，请在工作时间内联系热线：1900 7075-1900969681。";
    }
    
    UILabel *deductionRatioLabel = [[UILabel alloc] init];
    deductionRatioLabel.frame = CGRectMake(15, 40, DEVICE_Width-30, 40);
    deductionRatioLabel.backgroundColor = [UIColor clearColor];
    deductionRatioLabel.textColor = COL2;
    deductionRatioLabel.numberOfLines = 0;
    deductionRatioLabel.text = bmro.note;
    deductionRatioLabel.textAlignment = NSTextAlignmentLeft;
    deductionRatioLabel.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:deductionRatioLabel];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为8
    [paragraphStyle  setLineSpacing:8];
    
    
    if (bmro.note) {
        NSMutableAttributedString  *contentAttr = [[NSMutableAttributedString alloc] initWithString:deductionRatioLabel.text];
        [contentAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [deductionRatioLabel.text length])];
        deductionRatioLabel.attributedText = contentAttr;
        
        
        CGSize textSize = [deductionRatioLabel.text boundingRectWithSize:CGSizeMake(DEVICE_Width-30, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:deductionRatioLabel.font}
                                                               context:nil].size;
        
        int row = (int)(textSize.height/13)-1;
        if (row<0) {
            row = 0;
        }
        
        [footerView setHeight:80-14+textSize.height+8*row];
    }
    
    self.tableView.tableFooterView = footerView;
    
}


- (void)createHeadView {
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, DEVICE_Width, 80-12.5);
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *headlabel = [[UILabel alloc] init];
    headlabel.frame = CGRectMake(15, 0, DEVICE_Width-15, 40);
    headlabel.backgroundColor = [UIColor clearColor];
    headlabel.textColor = COL1;
    headlabel.text = @"取消政策";
    headlabel.textAlignment = NSTextAlignmentLeft;
    headlabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:headlabel];
    
    UILabel *cancelTimeLabel = [[UILabel alloc] init];
    cancelTimeLabel.frame = CGRectMake(15, 40, 150, 15);
    cancelTimeLabel.backgroundColor = [UIColor clearColor];
    cancelTimeLabel.textColor = COL1;
    cancelTimeLabel.text = @"取消时间";
    cancelTimeLabel.textAlignment = NSTextAlignmentLeft;
    cancelTimeLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:cancelTimeLabel];
    
    
    UILabel *deductionRatioLabel = [[UILabel alloc] init];
    deductionRatioLabel.frame = CGRectMake(DEVICE_Width-150-16, 40, 150, 15);
    deductionRatioLabel.backgroundColor = [UIColor clearColor];
    deductionRatioLabel.textColor = COL1;
    deductionRatioLabel.text = @"扣费比例";
    deductionRatioLabel.textAlignment = NSTextAlignmentRight;
    deductionRatioLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:deductionRatioLabel];
    
    self.tableView.tableHeaderView = headView;
    
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return self.dataArray.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"BackMoneyNoticeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier];
    }
    
    cell.textLabel.textColor = COL1;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.detailTextLabel.textColor = COL2;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    
    RoleObj *ro = [dataArr objectAtIndex:indexPath.row];
    
    NSArray *componds = [bmro.start_date componentsSeparatedByString:@"-"];
    
    if ([ro.from isEqualToString:@""]) {
        ro.from = @"0";
    }
    if ([ro.to isEqualToString:@""]) {
        ro.to = @"0";
    }
    
    if ([ro.from intValue] == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@年%@月%@日 开车前%@小时内",[componds firstObject],[componds objectAtIndex:1],[componds lastObject],ro.to];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",ro.fee,ro.currency_description];
    } else if ([ro.to intValue] == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@年%@月%@日 开车前%@小时以上",[componds firstObject],[componds objectAtIndex:1],[componds lastObject],ro.from];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",ro.fee,ro.currency_description];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@年%@月%@日 开车前%@小时-开车前%@小时",[componds firstObject],[componds objectAtIndex:1],[componds lastObject],ro.from,ro.to];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",ro.fee,ro.currency_description];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
    
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
