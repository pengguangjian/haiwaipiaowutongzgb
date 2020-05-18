//
//  CellHomeButtomViewCell.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHomeButtomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellHomeButtomViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *fubiaotilabel;


@property (nonatomic,strong) CellHomeButtomModel *model;

@end

NS_ASSUME_NONNULL_END
