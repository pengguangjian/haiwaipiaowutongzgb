//
//  CellHomeButtomView.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/27.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHomeButtomModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CellHomeButtomView : UITableViewCell

@property (nonatomic,strong)NSArray *itemArr;

@property (nonatomic, copy) void (^selectTagsModelBloak)(CellHomeButtomModel *model);

@end

NS_ASSUME_NONNULL_END
