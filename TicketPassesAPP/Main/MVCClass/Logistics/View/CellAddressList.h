//
//  CellAddressList.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CellAddressList : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,strong) AddressModel *model;

@end

NS_ASSUME_NONNULL_END
