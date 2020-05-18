//
//  XSZActivityRoleView.h
//  XiaoShunZiAPP
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 XiaoShunZi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSZActivityRoleView : UIView
+ (instancetype)sharedView:(TicketModel*)model;
- (void)show;
@end

NS_ASSUME_NONNULL_END
