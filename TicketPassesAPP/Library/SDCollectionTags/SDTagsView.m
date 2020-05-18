//
//  SDTagsView.m
//  SDTagsView
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "SDTagsView.h"
#import "SDCollectionTagsViewCell.h"
#import "SDHeader.h"
#import "SDHelper.h"
#import "TagsModel.h"
#define SDRectangleTagMaxCoult 3 // 矩阵标签时，最多列数

#define SDtagsView @"SDtagsView"
@interface SDTagsView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>


@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIView *sdTagsView;
@end

@implementation SDTagsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)sdTagsViewWithTagsArr:(NSArray*)tagsArr{
    SDTagsView *sdTagsView =[[SDTagsView alloc]init];
    sdTagsView.tagsArr =[[NSArray alloc]initWithArray:tagsArr];
    return sdTagsView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUP];
    }
    return self;
}

-(void)setUP{
    
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
- (void)setTagsArr:(NSArray *)tagsArr{
    _tagsArr = tagsArr;
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

       [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册
       [_collectionView registerClass:[SDCollectionTagsViewCell class] forCellWithReuseIdentifier:SDtagsView];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TagsModel *model =self.tagsArr[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@-%@",model.startModel.cityname,model.endModel.cityname];
    CGFloat width = [SDHelper widthForLabel:title fontSize:15];
    return CGSizeMake(width+10,30);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDCollectionTagsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDtagsView forIndexPath:indexPath];
    TagsModel *model =self.tagsArr[indexPath.row];
    
    [cell setValueWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagsModel *model =self.tagsArr[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@-%@",model.startModel.cityname,model.endModel.cityname];
    NSLog(@"index:%@",title);
    if(self.selectTagsBloak){
        self.selectTagsBloak(model);
    }
}

@end
