//
//  HomeCityCListVC.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCityCListVC : BaseViewController

@property (nonatomic, copy) void (^startCitySelectBloak)(CityModel *model);

@property (nonatomic, copy) void (^endCitySelectBloak)(CityModel *model);

@end

NS_ASSUME_NONNULL_END
