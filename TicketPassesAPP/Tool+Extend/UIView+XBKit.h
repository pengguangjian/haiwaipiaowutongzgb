//
//  UIView+XBKit.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/23.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XBKit)

- (UIViewController *)firstAvailableUIViewController;
- (id)traverseResponderChainForUIViewController ;

@end

NS_ASSUME_NONNULL_END
