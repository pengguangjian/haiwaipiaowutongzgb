//
//  CellHomeButtomView.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellHomeButtomView.h"
#import "CellHomeButtomViewCell.h"


@interface CellHomeButtomView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic,strong)UICollectionView *collectionView;



@end
@implementation CellHomeButtomView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.collectionView];
        
    }
    return self;
    
}
- (void)setItemArr:(NSArray *)itemArr{
    _itemArr = itemArr;
    
    [self.collectionView reloadData];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ww =  (SCREEN_WIDTH - 45) /2;
    CGFloat hh = ww * 380.0f/330.0f+40;
    
    return CGSizeMake( ww,hh);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellHomeButtomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellHomeButtomViewCell" forIndexPath:indexPath];

    CellHomeButtomModel *model = [CellHomeButtomModel mj_objectWithKeyValues:self.itemArr[indexPath.row]];

    cell.model = model;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     CellHomeButtomModel *model = [CellHomeButtomModel mj_objectWithKeyValues:self.itemArr[indexPath.row]];
    if(self.selectTagsModelBloak){
        self.selectTagsModelBloak(model);
    }    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromHex(0xf6f6f6);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"CellHomeButtomViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellHomeButtomViewCell"];
    }
    return _collectionView;
}

@end
