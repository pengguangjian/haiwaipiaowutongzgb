//
//  ContactListVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "ContactListVC.h"

#import "CellEditorAddress.h"
#import "addOrEditContactVC.h"
#import "ContactObj.h"

@interface ContactListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addressNewBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,assign) BOOL isUpdata;

@end

@implementation ContactListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"联系人列表");
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addressNewBtn];
    
    WEAK_SELF;
    [self.tableView tableViewPullDown:^{
        [weakSelf requestContact];
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
        [_addressNewBtn setTitle:NSBundleLocalizedString(@"添加联系人") forState:UIControlStateNormal];
        [_addressNewBtn addTarget:self action:@selector(newAddressChlick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressNewBtn;
}

- (void)newAddressChlick{
    AddOrEditContactVC *addOrEditContactVC = [[AddOrEditContactVC alloc] init];
    WEAK_SELF;
    [addOrEditContactVC setBackSuccessBlock:^(){
        [weakSelf requestContact];
    }];
    [self.navigationController pushViewController:addOrEditContactVC animated:YES];
}

- (void)goEditor:(ContactObj *)co{
    WEAK_SELF;
    AddOrEditContactVC *vc = [[AddOrEditContactVC alloc]init];
    vc.co = co;
    [vc setBackSuccessBlock:^(){
        weakSelf.isUpdata = YES;
        [weakSelf requestContact];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)goRemove:(ContactObj *)co cell:(CellEditorAddress *)cell{
    WEAK_SELF;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
            
            if ([rd.code isEqualToString:SUCCESS] ) {
                
                [MBManager showBriefAlert:NSBundleLocalizedString(@"删除成功")];
                [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
                [weakSelf.tableView reloadData];
                
            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });
    };
    
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:co.id forKey:@"id"];
    
    [hm getRequetInterfaceData:dataDic withInterfaceName:@"/api/contacts/delete"];
    
}
- (void)requestContact{
    
    WEAK_SELF;
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
            
            if ([rd.code isEqualToString:SUCCESS] ) {
                
                [weakSelf.tableView headerEndRefreshing];
                
                NSDictionary *dic = [rd.data valueForKey:@"contacts"];
                weakSelf.dataArray = [ContactObj mj_objectArrayWithKeyValuesArray:dic];
                
                [weakSelf.tableView reloadData];
                
            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });
    };
    
    [hm getRequetInterfaceData:nil withInterfaceName:@"/api/contacts/getlist"];
    
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
    ContactObj *co = self.dataArray[indexPath.row];
    cell.model = co;
    WEAK_SELF;
    [cell setEditorClickBlock:^(ContactObj *co){
        [weakSelf goEditor:co];
    }];
    [cell setRemoveClickBlock:^(ContactObj *co,CellEditorAddress *cell){
        [weakSelf goRemove:co cell:cell];
    }];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactObj *model = self.dataArray[indexPath.row];
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
