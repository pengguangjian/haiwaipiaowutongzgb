//
//  ContactObj.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/28.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactObj : NSObject
@property(nonatomic, strong) NSNumber* id;//
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property(nonatomic, strong) NSNumber* card_type;//证件类型1护照 2身份证
@property (nonatomic, copy) NSString *card_number;
@property(nonatomic, strong) NSNumber* is_default;
@property(nonatomic, strong) NSNumber* is_delete;
@property (nonatomic, copy) NSString *create_time;
@end

NS_ASSUME_NONNULL_END
