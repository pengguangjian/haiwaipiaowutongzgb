//
//  HomeCityHotcityCollectionTagsViewCell.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/30.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCityHotcityCollectionTagsViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *title;
-(void)setValueWithModel:(CityModel *)model;


@end

NS_ASSUME_NONNULL_END
