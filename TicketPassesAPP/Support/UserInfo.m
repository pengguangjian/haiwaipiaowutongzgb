//
//  UserInfo.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "UserInfo.h"

#define LOGIN_USER_INFO @"LOGIN_USER_INFO"//保存用户登录信息KEY
#define LOGIN_USER_LOG @"LOGIN_USER_LOG"//是否登录信息KEY

@implementation UserInfo

static UserInfo *userinfo;
+ (UserInfo *)sharedInstance {
    static dispatch_once_t longOnce;
    dispatch_once(&longOnce, ^{
        userinfo = [[UserInfo alloc] init];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userinfo.isLog = [userDefaults boolForKey:LOGIN_USER_LOG];
        if(userinfo.isLog){
            NSLog(@"已经登录");
           
        }else{
            NSLog(@"未登录");
        }
        NSDictionary *userInfo = [userDefaults objectForKey:LOGIN_USER_INFO];
        userinfo.userModel =  [UserModel mj_objectWithKeyValues:userInfo];
    });
    return userinfo;
}
-(void)updateLoginUserInfo:(UserModel *)model{
    
    [UserInfo sharedInstance].isLog = YES;
    [UserInfo sharedInstance].userModel = model;
    
    //    model.userId = model.ID;
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:[model mj_keyValues]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dicInfo forKey:LOGIN_USER_INFO];
    //设置用户数据代表登录了的
    [userDefaults setBool:YES forKey:LOGIN_USER_LOG];
    [userDefaults synchronize];

}
-(void)deleteLoginUserInfo{
    
    [UserInfo sharedInstance].isLog = NO;
    [UserInfo sharedInstance].userModel = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:LOGIN_USER_INFO];
    //清除用户数据代表退出登录了
    [userDefaults setBool:NO forKey:LOGIN_USER_LOG];
    [userDefaults synchronize];
    
    
}
-(UserModel *)fetchLoginUserInfo{
    
    return [UserInfo sharedInstance].userModel;
}
-(BOOL)isLogined{
    
    BOOL islog = [UserInfo sharedInstance].isLog;
    if(islog){
//        NSLog(@"已经登录");
        return YES;
    }else{
//        NSLog(@"未登录");
        return NO;
    }
}

@end
