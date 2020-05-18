//
//  NewAddressVC.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/7/1.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewAddressVC : BaseViewController

@property (strong, nonatomic) NSString  *nameStr;
@property (strong, nonatomic) NSString  *iphoneStr;
@property (strong, nonatomic) NSString  *addressStr;

@property (strong, nonatomic) NSString  *ad_id;


@property (nonatomic, copy) void (^backSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
