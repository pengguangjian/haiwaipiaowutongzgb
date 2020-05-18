//
//  AddOrEditContactVC.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "ContactObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddOrEditContactVC : BaseViewController


@property (nonatomic, strong)ContactObj *co;

@property (nonatomic, copy) void (^backSuccessBlock)(void);
@end

NS_ASSUME_NONNULL_END
