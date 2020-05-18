//
//  HomeADModel.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeADModel : BaseModel

@property (nonatomic, copy) NSNumber *ab_status;
@property (nonatomic, copy) NSString *ab_create_at;
@property (nonatomic, copy) NSString *ab_img_url;
@property (nonatomic, copy) NSString *ab_intro;
@property (nonatomic, copy) NSNumber *ab_id;
@property (nonatomic, copy) NSString *ab_title;

@end

NS_ASSUME_NONNULL_END
