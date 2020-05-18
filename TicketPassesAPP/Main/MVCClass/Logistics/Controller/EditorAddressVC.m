//
//  EditorAddressVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "EditorAddressVC.h"
#import "CellEditorAddress.h"
#import "NewAddressVC.h"

#import "AddressModel.h"

@interface EditorAddressVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addressNewBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL isUpdata;

@end

@implementation EditorAddressVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"地址列表");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addressNewBtn];
    
    WEAK_SELF;
    [self.tableView tableViewPullDown:^{
        [weakSelf requestMyaddress];
    }];
    [self.tableView headerBeginRefreshing];
}
- (void)willMoveToParentViewController:(UIViewController *)parent {
    if(self.isUpdata){
        self.isUpdata = NO;
        if(self.backSuccessBlock){
            self.backSuccessBlock();
        }
    }
}

- (UIButton *)addressNewBtn{
    if (!_addressNewBtn) {
        _addressNewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addressNewBtn.frame = CGRectMake(20,SCREENH_HEIGHT-50-SYS_TabBarFloatHeight, SCREEN_WIDTH-40, 40);
        [_addressNewBtn setBackgroundImage:kSetImage(@"按钮背景") forState:UIControlStateNormal];
        [_addressNewBtn setTitle:NSBundleLocalizedString(@"添加地址") forState:UIControlStateNormal];
        [_addressNewBtn addTarget:self action:@selector(newAddressChlick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressNewBtn;
}

- (void)newAddressChlick{
    NewAddressVC *newAddVC = [[NewAddressVC alloc] init];
    WEAK_SELF;
    [newAddVC setBackSuccessBlock:^(){
        [weakSelf requestMyaddress];
    }];
    [self.navigationController pushViewController:newAddVC animated:YES];
}

- (void)goEditor:(AddressModel *)model{
    WEAK_SELF;
    NewAddressVC *vc = [[NewAddressVC alloc]init];
    vc.ad_id = model.ad_id;
    vc.nameStr = model.ad_consignee;
    vc.iphoneStr = model.ad_consignee_phone;
    vc.addressStr = model.ad_get_address;
    [vc setBackSuccessBlock:^(){
        weakSelf.isUpdata = YES;
        [weakSelf requestMyaddress];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)goRemove:(AddressModel *)model cell:(CellEditorAddress *)cell{
    WEAK_SELF;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [AFHTTP requestDeladdressAd_id:model.ad_id success:^(NSDictionary *dic){
        [MBManager showBriefAlert:NSBundleLocalizedString(@"删除成功")];
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView reloadData];
    }];
    
}
- (void)requestMyaddress{
    
    WEAK_SELF;
    [AFHTTP requestMyaddressSuccess:^(NSDictionary *dic){
        
        [weakSelf.tableView headerEndRefreshing];
        NSArray *addressdatas = dic[@"addressdatas"];
        if([addressdatas isKindOfClass:[NSArray class]]){
            [weakSelf.dataArray removeAllObjects];
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
    static NSString *identifier = @"CellEditorAddress";
    CellEditorAddress * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell= [[[NSBundle  mainBundle]  loadNibNamed:@"CellEditorAddress" owner:self options:nil]  lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressModel *model = [AddressModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    cell.model = model;
    WEAK_SELF;
    [cell setEditorClickBlock:^(AddressModel *model){
        [weakSelf goEditor:model];
    }];
    [cell setRemoveClickBlock:^(AddressModel *model,CellEditorAddress *cell){
        [weakSelf goRemove:model cell:cell];
    }];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressModel *model = [AddressModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    if(self.startSelectSuccessBlock){
        self.startSelectSuccessBlock(model);
        [self onBack];
    }
    if(self.endSelectSuccessBlock){
        self.endSelectSuccessBlock(model);
        [self onBack];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-SYS_TopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromHex(0xf6f6f6);
    }
    return _tableView;
}

@end
