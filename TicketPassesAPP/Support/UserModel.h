//
//  UserModel.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

//id
@property (nonatomic,strong) NSString *ID;
//用户id
@property (nonatomic,strong) NSString *user_id;

@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *create_at;


@end
