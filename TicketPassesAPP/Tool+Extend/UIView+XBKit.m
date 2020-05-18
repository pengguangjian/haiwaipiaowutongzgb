//
//  UIView+XBKit.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/23.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "UIView+XBKit.h"

@implementation UIView (XBKit)

- (UIViewController *)firstAvailableUIViewController {
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end
