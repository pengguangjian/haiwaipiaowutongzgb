//
//  HomeCityHotcityCell.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCityHotcityCell : UITableViewCell
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UIView *hotcityView;

//ddd
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSArray *tagsArr;

@property (nonatomic, copy) void (^clickItemSelectBloak)(CityModel *model);



@end

NS_ASSUME_NONNULL_END
