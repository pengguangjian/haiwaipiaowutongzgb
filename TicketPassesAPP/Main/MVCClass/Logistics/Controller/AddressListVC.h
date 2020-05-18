//
//  AddressListVC.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressListVC : BaseViewController
    
    
    @property (nonatomic, copy) void (^startSelectSuccessBlock)(AddressModel *model);
    
    @property (nonatomic, copy) void (^endSelectSuccessBlock)(AddressModel *model);

@end

NS_ASSUME_NONNULL_END
