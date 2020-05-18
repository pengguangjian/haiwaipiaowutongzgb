//
//  BackMoneyRoleObj.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackMoneyRoleObj : NSObject

@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *english_note;
@property (nonatomic, copy) NSString *internal_note;
@property (nonatomic, copy) NSString *use_all_route;
@end

NS_ASSUME_NONNULL_END
