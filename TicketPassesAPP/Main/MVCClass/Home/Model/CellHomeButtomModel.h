//
//  CellHomeButtomModel.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellHomeButtomModel : BaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSNumber *catid;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSNumber *state;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *vice_title;
@property (nonatomic, copy) NSNumber *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *update_at;
@property (nonatomic, copy) NSString *hits;
@property (nonatomic, copy) NSNumber *sort;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *content;


@end

NS_ASSUME_NONNULL_END
