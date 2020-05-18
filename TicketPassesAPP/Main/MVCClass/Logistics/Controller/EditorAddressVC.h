//
//  EditorAddressVC.h
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditorAddressVC : BaseViewController

@property (nonatomic, copy) void (^startSelectSuccessBlock)(AddressModel *model);

@property (nonatomic, copy) void (^endSelectSuccessBlock)(AddressModel *model);


@property (nonatomic, copy) void (^backSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
