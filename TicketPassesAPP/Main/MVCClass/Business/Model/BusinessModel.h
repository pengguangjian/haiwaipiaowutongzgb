//
//  BusinessModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/14.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessModel : BaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vice_title;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *url;


@end

NS_ASSUME_NONNULL_END
