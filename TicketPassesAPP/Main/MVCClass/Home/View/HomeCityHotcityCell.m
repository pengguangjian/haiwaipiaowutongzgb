//
//  HomeCityHotcityCell.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "HomeCityHotcityCell.h"
#import "HomeCityHotcityCollectionTagsViewCell.h"


@implementation HomeCityHotcityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.hotcityView.backgroundColor = UIColorFromHex(0xf6f6f6);
    [self.hotcityView addSubview:self.collectionView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-35);
}
- (void)setTagsArr:(NSArray *)tagsArr{
    _tagsArr = tagsArr;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromHex(0xf6f6f6);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册
        
        [_collectionView registerClass:[HomeCityHotcityCollectionTagsViewCell class] forCellWithReuseIdentifier:@"HomeCityHotcityCollectionTagsViewCell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat itmew =  (SCREEN_WIDTH -50) / 4;
    return CGSizeMake(itmew,33);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCityHotcityCollectionTagsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCityHotcityCollectionTagsViewCell" forIndexPath:indexPath];
    
    CityModel *model = [CityModel mj_objectWithKeyValues:self.tagsArr[indexPath.row]];
    [cell setValueWithModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *model = [CityModel mj_objectWithKeyValues:self.tagsArr[indexPath.row]];
    NSLog(@"index:%@",model.cityname);
    if(self.clickItemSelectBloak){
        self.clickItemSelectBloak(model);
    }
}

@end
