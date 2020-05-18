//
//  WebModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/14.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebModel : BaseModel

@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *Description;

@end
NS_ASSUME_NONNULL_END
