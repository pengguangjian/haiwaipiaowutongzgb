//
//  DHSelectSeatView.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/25.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "DHSelectSeatView.h"
#import "UIView+Size.h"
#import "Masonry.h"

#import "SubTimeCell.h"
#import "SeatObj.h"

@interface DHSelectSeatView ()
{
    UIView *bgView;
    float bgViewHeight;
    
    UIView *containerBtnView;
    
    NSMutableArray *dayBtnArr;
    
    NSMutableArray *thirdArr;
    
    NSMutableArray *dayArr;
    
    NSString *tripId;
    
    NSMutableArray *selectArr;
    
}
@property (nonatomic, strong) NSMutableArray *subTimeDataSource;
@property (nonatomic, strong) UICollectionView *subTimeCollectionView;

@end

@implementation DHSelectSeatView

+ (instancetype)sharedView:(NSString*)tripID {
    
    static dispatch_once_t once;
    static DHSelectSeatView *selectSeatView;
    dispatch_once(&once, ^ {
        selectSeatView = [[self alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
        
        [selectSeatView setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        
    });
    
    [selectSeatView removeAllView];
    [selectSeatView initView : tripID];
    
    return selectSeatView;
    
}

- (void)removeAllView
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

/**
 *  绘制界面
 */
- (void)initView:(NSString*)tripID
{
    
    tripId = tripID;
    
    [self getSeatList:tripId];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    //    [self addGestureRecognizer:tapGesture];
    
    bgViewHeight = DEVICE_Height*0.8;
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_Height, DEVICE_Width, bgViewHeight)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bgView];
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = COL1;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"选择座位";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(bgView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(DEVICE_Width, 50));
    }];
    
    UIButton *closeAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeAddBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeAddBtn setTitleColor:COL2 forState:UIControlStateHighlighted];
    [closeAddBtn setTitleColor:COL1 forState:UIControlStateNormal];
    closeAddBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [closeAddBtn addTarget:self action:@selector(closeAddBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeAddBtn];
    [closeAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(0);
        make.left.equalTo(bgView).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:COL1 forState:UIControlStateNormal];
    [ensureBtn setTitleColor:COL2 forState:UIControlStateHighlighted];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [ensureBtn addTarget:self action:@selector(ensureBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:ensureBtn];
    [ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).with.offset(0);
        make.right.equalTo(bgView).with.offset(-14);
        //        make.size.mas_equalTo(CGSizeMake(DEVICE_Width/2.0, 50));
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [bgView addSubview:self.subTimeCollectionView];
    
}





- (UICollectionView *)subTimeCollectionView
{
    if (!_subTimeCollectionView)
    {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 0;
        //上下间距
        flowlayout.minimumLineSpacing = 16;
        
        _subTimeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, DEVICE_Width, bgViewHeight-66) collectionViewLayout:flowlayout];
        _subTimeCollectionView.delegate = self;
        _subTimeCollectionView.dataSource = self;
        
        _subTimeCollectionView.showsVerticalScrollIndicator = NO;
        _subTimeCollectionView.showsHorizontalScrollIndicator = NO;
        [_subTimeCollectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [self.subTimeCollectionView registerClass:[SubTimeCell class] forCellWithReuseIdentifier:@"SubTimeCell"];
        //注册分区头标题
        [self.subTimeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubTimeCollectionViewHeaderView"];
        [bgView addSubview:_subTimeCollectionView];
    }
    return _subTimeCollectionView;
}


- (void)ensureBtnOnTouch:(id)sender
{
    selectArr = [[NSMutableArray alloc] init];
    for (NSArray *arr in self.subTimeDataSource) {
        for (SeatObj *so in arr) {
            if ([so.status intValue] == 5) {
                [selectArr addObject:so];
            }
        }
    }
    
    if (selectArr.count<=0) {
        [SVProgressHUD showErrorWithStatus:@"最少选择一个座位"];
        return;
    }
    
    
    
    if (self.handler) {
        self.handler(selectArr);
    }
    
    [self hiddenView];
}

- (void)closeAddBtnOnTouch:(id)sender {
//    if (self.handler) {
//        self.handler(nil, nil);
//    }
    
    [self hiddenView];

}


- (void)hiddenView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        bgView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        
        __block DHSelectSeatView *weakSelf = self;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [weakSelf removeFromSuperview];
        });
        
    } completion:^(BOOL finished){
        
    }];
}


- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    [self hiddenView];
}

- (void)show{
    
    [UIView animateWithDuration:0.5 animations:^{
        bgView.layer.transform = CATransform3DMakeTranslation(0, -bgViewHeight, 0);
    } completion:^(BOOL finished){
        
    }];
    
}


#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.subTimeDataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = [self.subTimeDataSource objectAtIndex:section];
    return arr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubTimeCell" forIndexPath:indexPath];
   
    NSArray *arr = [self.subTimeDataSource objectAtIndex:indexPath.section];
    SeatObj *so = [arr objectAtIndex:indexPath.row];
    
    
    [cell setSeatObj:so];
    
    cell.timeBtn.tag = indexPath.section*100 + indexPath.row;
    [cell.timeBtn addTarget:self action:@selector(timeBtnOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSString *dateStr = [NSString stringWithFormat:@"%@ %@:00",dateObj.workDate,wto.workTime];
//
//    if ([dateStr isEqualToString:_selectDateStr]) {
//        [cell.timeBtn setBackgroundColor:DEFAULTCOLOR2];
//    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    selectedIndexPath = indexPath;
//    selectedDayIndex = currentDayIndex;
//    [self.subTimeCollectionView reloadData];
//
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DEVICE_Width - 16*4) / 4.0,
                      (DEVICE_Width - 16*4) / 4.0*(9.0/16.0));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SubTimeCollectionViewHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 22, DEVICE_Width-32, 1)];
        [lineView setBackgroundColor:COL2];
        [headerView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((DEVICE_Width-85)/2.0, 0, 85, 45)];
        switch (indexPath.section) {
            case 0:
                titleLabel.text = @"一层";
                break;
            case 1:
                titleLabel.text = @"二层";
                break;
            case 2:
                titleLabel.text = @"三层";
                break;
            case 3:
                titleLabel.text = @"四层";
                break;
                
            default:
                break;
        }
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = COL2;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:titleLabel];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DEVICE_Width, 45);
}

- (void)timeBtnOnTouch:(UIButton*)btn {

    NSMutableArray *arr = [self.subTimeDataSource objectAtIndex:btn.tag/100];
    SeatObj *so = [arr objectAtIndex:btn.tag%100];
    
    if ([so.status intValue] == 0) {
        so.status = [NSNumber numberWithInt:1];
    }
    
    if ([so.status intValue] == 1) {
        so.status = [NSNumber numberWithInt:5];
    } else {
        so.status = [NSNumber numberWithInt:1];
    }
    
    [arr replaceObjectAtIndex:btn.tag%100 withObject:so];
    [self.subTimeDataSource replaceObjectAtIndex:btn.tag/100 withObject:arr];
    
    
    [self.subTimeCollectionView reloadData];
    
}


#pragma mark --

- (void)getSeatList:(NSString*)tripid {
    
//    [SVProgressHUD showWithStatus:@"加载中"];
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
        
        if ([rd.code isEqualToString:SUCCESS]) {
            
            NSArray *dic = [rd.data valueForKey:@"seats"];
            
            self.subTimeDataSource = [[NSMutableArray alloc] init];
            for (NSArray *arr in dic) {

                NSArray *tempArr = [SeatObj mj_objectArrayWithKeyValuesArray:arr];
                [self.subTimeDataSource addObject:tempArr];
            }
            
            [self.subTimeCollectionView reloadData];
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:rd.msg];
            });
        }
    };
    
    NSDictionary *dic = @{@"trip_code":tripId};
    [hm getRequetInterfaceData:dic withInterfaceName:@"/api/ticket/seatmap"];
    
}

@end
