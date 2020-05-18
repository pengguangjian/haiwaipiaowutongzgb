//
//  RoleObj.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoleObj : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *disable_cancel;
@property (nonatomic, copy) NSString *currency_description;
@property (nonatomic, copy) NSString *cancelable;

@end

NS_ASSUME_NONNULL_END
