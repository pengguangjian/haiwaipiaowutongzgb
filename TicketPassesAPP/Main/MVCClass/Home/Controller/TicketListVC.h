//
//  TicketListVC.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/2.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "XBCalendar.h"
NS_ASSUME_NONNULL_BEGIN

@interface TicketListVC : BaseViewController


@property (nonatomic, strong) NSString *startCityid;

@property (nonatomic, strong) NSString *endCityid;

@property (nonatomic, strong) NSString *startCityName;

@property (nonatomic, strong) NSString *endCityiName;

@property (nonatomic,strong) LXCalendarDayModel *setout_time;

@property (nonatomic, strong) XBCalendar *calendar;


@end

NS_ASSUME_NONNULL_END
