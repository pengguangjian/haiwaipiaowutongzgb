//
//  CommentObj.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/6.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentObj : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *on_time_rating;
@property (nonatomic, copy) NSString *vehicile_quality_rating;
@property (nonatomic, copy) NSString *data_of_journey;
@property (nonatomic, copy) NSString *service_rating;
@property (nonatomic, copy) NSString *rating_date;
@property (nonatomic, copy) NSString *overall_rating;
@property (nonatomic, copy) NSString *first_name;

@end

NS_ASSUME_NONNULL_END
