//
//  BindingLoginVC.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/8/31.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindingLoginVC : BaseViewController

//zalo  和 fackbook
@property (nonatomic,strong) NSString *type;

//facebookprom  和 zaloprom
@property (nonatomic,strong) NSDictionary *prom;

@end

NS_ASSUME_NONNULL_END
