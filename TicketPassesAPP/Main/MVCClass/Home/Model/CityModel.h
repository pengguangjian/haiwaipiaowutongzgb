//
//  CityModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : BaseModel

@property (nonatomic, copy) NSString *is_hot;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSNumber *country_type;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *acronym;
@property (nonatomic, copy) NSString *cityname_y;
@property (nonatomic, copy) NSString *cityname_e;
@property (nonatomic, copy) NSString *cityname_c;
@property (nonatomic ,copy) NSString *cityname;
//@property (nonatomic, copy) NSString *create_at;

@end

NS_ASSUME_NONNULL_END
