//
//  BusinessVC.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BusinessVC.h"
#import "BusinessModel.h"
#import "BusinessCell.h"

@interface BusinessVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

//ddd
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation BusinessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    WEAK_SELF;
    [self.collectionView tableViewPullDown:^{
        [weakSelf requestNewslist];
    }];
    [self.collectionView headerBeginRefreshing];
    
}

- (void)requestNewslist {
    WEAK_SELF;
    [AFHTTP requestNewslistSuccess:^(id responseObject){
        
        [weakSelf.collectionView headerEndRefreshing];
        [weakSelf.dataArray removeAllObjects];
        NSArray *newsdatas = responseObject[@"newsdatas"];
        if([newsdatas isKindOfClass:[newsdatas class]]){
            [weakSelf.dataArray addObjectsFromArray:responseObject[@"newsdatas"]];
            [weakSelf.collectionView reloadData];
        }
    } failure:^(NSError *error){
        [weakSelf.collectionView headerEndRefreshing];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH,250);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BusinessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BusinessCell" forIndexPath:indexPath];
    
    BusinessModel *model = [BusinessModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    
    cell.model = model;
    
//    // 阴影颜色
//    cell.layer.shadowColor = RGB(225, 0, 0).CGColor;
//    // 阴影偏移，默认(0, -3)
//    cell.layer.shadowOffset = CGSizeMake(0,8);
//    // 阴影透明度，默认0
//    cell.layer.shadowOpacity = 1;
//    // 阴影半径，默认3
//    cell.layer.shadowRadius = 8;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BusinessModel *model = [BusinessModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    WebViewController *vc = [[WebViewController alloc]init];
    vc.webType = 5;
    vc.newsId = model.ID;
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
    [self.collectionView headerBeginRefreshing];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SYS_TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SYS_ALLDUD) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromHex(0xf6f6f6);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
//        [_collectionView setBackgroundColor:[UIColor redColor]];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellWithReuseIdentifier:@"BusinessCell"];
    }
    return _collectionView;
}

@end
