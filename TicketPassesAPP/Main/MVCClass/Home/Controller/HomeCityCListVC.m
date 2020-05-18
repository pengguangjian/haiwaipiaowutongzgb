//
//  HomeCityCListVC.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "HomeCityCListVC.h"
#import "HomeCityCell.h"
#import "HomeCityHotcityCell.h"
#import "CityModel.h"
#import "YDSearchBar.h"

@interface HomeCityCListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong , nonatomic) NSMutableArray *dataArray;

@property (strong , nonatomic) NSMutableArray *hotcityDataArray;

@property (nonatomic, strong)  YDSearchBar *searchBar;

@end

@implementation HomeCityCListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSBundleLocalizedString(@"选择城市");
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    
    WEAK_SELF;
    [AFHTTP requestHotcitySuccess:^(NSDictionary *dic){

        NSArray *citydatas = dic[@"citydatas"];
        if([citydatas isKindOfClass:[NSArray class]]){
            //处理数据
            [weakSelf.hotcityDataArray removeAllObjects];
            [weakSelf.hotcityDataArray addObjectsFromArray:citydatas];
        }
        [weakSelf.tableView reloadData];
        
    }];
   
    [AFHTTP requestChoicecitySuccess:^(NSDictionary *dic){

        NSArray *citydatas = dic[@"citydatas"];
        if([citydatas isKindOfClass:[NSArray class]]){
            //处理数据
            [weakSelf upDataArray:citydatas];
        }
        [weakSelf.tableView reloadData];

    }];
    
    [self createSearchView];
    
}


- (void)createSearchView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, DEVICE_Width, 46)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    
    _searchBar = [[YDSearchBar alloc] initWithFrame:CGRectMake(20, 8, DEVICE_Width-40, 30)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索城市";
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.showsCancelButton = NO;
    [_searchBar setTintColor:DEFAULTCOLOR2];
    _searchBar.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 46)];
    [wrapView addSubview:_searchBar];
    [headView addSubview:wrapView];
    
    [self.view addSubview: headView];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString:@""]) {
        
        WEAK_SELF;
        [AFHTTP requestChoicecitySuccess:^(NSDictionary *dic){

            NSArray *citydatas = dic[@"citydatas"];
            if([citydatas isKindOfClass:[NSArray class]]){
                //处理数据
                [weakSelf upDataArray:citydatas];
            }
            [weakSelf.tableView reloadData];
            
            [weakSelf.view endEditing:YES];

        }];
        
    } else {
        
        WEAK_SELF;
        HttpManager *hm = [HttpManager createHttpManager];
        hm.responseHandler = ^(id responseObject) {

            dispatch_async(dispatch_get_main_queue(), ^{

                ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];

                if ([rd.code isEqualToString:SUCCESS] ) {

                    NSArray *citydatas = [rd.data objectForKey:@"data"];
                    if([citydatas isKindOfClass:[NSArray class]]){
                        //处理数据
                        [weakSelf upDataArray:citydatas];
                    }
                    [weakSelf.tableView reloadData];

                } else {
                    [SVProgressHUD showErrorWithStatus:rd.msg];
                }
            });

        };

        NSDictionary *dataDic = @{@"name":searchText};

        [hm getRequetInterfaceData:dataDic withInterfaceName:@"api/ticket/getCity"];
        
        
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

- (void)upDataArray:(NSArray *)array{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
    for (NSDictionary *dic in array) {
        CityModel *model = [CityModel mj_objectWithKeyValues:dic];
        NSMutableArray *array =  [tempDic objectForKey:model.acronym];
        if([array isKindOfClass:[NSArray class]]){
            [array addObject:model];
        }else{
            NSMutableArray *tarray = [[NSMutableArray alloc]init];
            [tarray addObject:model];
            [tempDic setObject:tarray forKey:model.acronym];
        }
    }
    NSArray *resultkArrSort = [tempDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *arraygg = [[NSMutableArray alloc]init];
    for (NSString *key in resultkArrSort) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:key forKey:@"acronym"];
        [arraygg addObject:dic];
        [arraygg addObjectsFromArray:tempDic[key]];
    }
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:arraygg];
    
    [self.tableView reloadData];

}

#pragma mark ----   tableview ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        
        return self.hotcityDataArray.count >0 ? 1 : 0;
    }else{
        return self.dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString *identifier = @"HomeCityHotcityCell";
        HomeCityHotcityCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell= [[[NSBundle  mainBundle]  loadNibNamed:@"HomeCityHotcityCell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromHex(0xf6f6f6);
        cell.tagsArr = self.hotcityDataArray;
        WEAK_SELF;
        [cell setClickItemSelectBloak:^(CityModel *model){
            if(weakSelf.startCitySelectBloak){
                weakSelf.startCitySelectBloak(model);
                [weakSelf onBack];
            }
            if(weakSelf.endCitySelectBloak){
                weakSelf.endCitySelectBloak(model);
                [weakSelf onBack];
            }
        }];
        return cell;
        
    }else{
        static NSString *identifier = @"HomeCityCell";
        HomeCityCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell= [[[NSBundle  mainBundle]  loadNibNamed:@"HomeCityCell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        id data = self.dataArray [indexPath.row];
        if([data isKindOfClass:[CityModel class]]){
            CityModel *model = data;
            cell.caleLabel.hidden = YES;
            cell.addressLabel.hidden = NO;
            cell.backgroundColor = [UIColor whiteColor];
            cell.caleLabel.text = @"";
            cell.addressLabel.text = model.cityname;
        } else {
            NSDictionary *model = data;
            cell.caleLabel.hidden = NO;
            cell.addressLabel.hidden = YES;
            cell.backgroundColor = UIColorFromHex(0xf6f6f6);
            cell.caleLabel.text  =  model[@"acronym"];
            cell.addressLabel.text = @"";

        }
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.section == 0){
        
        NSInteger number = ceilf(self.hotcityDataArray.count /4.0);
        
        CGFloat hhh = number * 33 + 35 + ((number - 1) *10);
    
        return hhh;
        
    }else{
        id data = self.dataArray [indexPath.row];
        if([data isKindOfClass:[CityModel class]]){
            return 60;
        }else{
            return 45;
        }
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id data = self.dataArray [indexPath.row];
    if([data isKindOfClass:[CityModel class]]){
        CityModel *model = data;
        if(self.startCitySelectBloak){
            self.startCitySelectBloak(model);
            [self onBack];
        }
        if(self.endCitySelectBloak){
            self.endCitySelectBloak(model);
            [self onBack];
        }
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
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}

- (NSMutableArray *)hotcityDataArray {
    if(!_hotcityDataArray){
        _hotcityDataArray = [[NSMutableArray alloc]init];
    }
    return _hotcityDataArray;
}
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SYS_TopHeight+46, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_TopHeight-46) style:UITableViewStylePlain];
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
