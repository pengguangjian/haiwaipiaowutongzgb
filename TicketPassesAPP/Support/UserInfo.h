//
//  UserInfo.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
/**
 *  UserInfo是一个单例,存取删除登录信息
 */
@interface UserInfo : NSObject

//是否登录
@property (nonatomic,assign) BOOL isLog;
//用户model
@property (nonatomic,strong) UserModel *userModel;
/**
 *  获取UserInfo对象,UserInfo
 *
 *  @return UserInfo对象
 */
+ (UserInfo *)sharedInstance;
/**
 *  更新登录用信息
 */
-(void)updateLoginUserInfo:(UserModel *)model;
/**
 *  删除保存的登录用户信息
 */
-(void)deleteLoginUserInfo;
/**
 *  获取用户登录信息
 *
 *  @return ModelLogin 用户信息对象实体
 */
-(UserModel *)fetchLoginUserInfo;
/**
 *  是否登录
 */
-(BOOL)isLogined;
@end

