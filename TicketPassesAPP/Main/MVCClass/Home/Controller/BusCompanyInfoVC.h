//
//  BusCompanyInfoVC.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseVC.h"
#import "MSNavSliderMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusCompanyInfoVC : BaseVC
@property (nonatomic, copy) NSString *trip_code;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, assign) MSNavSliderMenuType menuType;
@end

NS_ASSUME_NONNULL_END
