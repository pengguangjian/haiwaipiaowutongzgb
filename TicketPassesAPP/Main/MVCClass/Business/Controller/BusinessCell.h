//
//  BusinessCell.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/12.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BusinessCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *fubiaotilabel;
@property (strong, nonatomic) IBOutlet UIView *bgview;

@property (nonatomic,strong) BusinessModel *model;;

@end

NS_ASSUME_NONNULL_END
