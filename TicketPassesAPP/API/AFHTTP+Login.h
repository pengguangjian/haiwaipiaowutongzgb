//
//  AFHTTP+Login.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTP (Login)

    
/**
 登录

 @param phone <#phone description#>
 @param password <#password description#>
 */
+ (void)requestPasswordLoginPhone:(NSString *)phone
                         password:(NSString *)password;
    
/**
 登录

 @param phone <#phone description#>
 @param Code <#Code description#>
 */
+ (void)requestLoginPhone:(NSString *)phone
                  andCode:(NSString *)Code;


/**
 zalo检查登录
 如已绑定手机号 则根据返回userid获取用户信息进入首页
 */
+ (void)requestZalologinzalo_id:(NSString *)zalo_id
                        success:(HttpRequestSuccess)success;


+ (void)requestAppleloginApple_id:(NSString *)apple_id
                          success:(HttpRequestSuccess)success;


/**
 脸书检查登录
 如已绑定手机号 则根据返回userid获取用户信息进入首页
 */
+ (void)requestFacebookloginfb_id:(NSString *)fb_id
                          success:(HttpRequestSuccess)success;

/**
 WX检查登录
 如已绑定手机号 则根据返回userid获取用户信息进入首页
 */
+ (void)requestWXloginwx_id:(NSString *)wx_id
                          success:(HttpRequestSuccess)success;

/**
 QQ检查登录
 如已绑定手机号 则根据返回userid获取用户信息进入首页
 */
+ (void)requestQQloginqq_id:(NSString *)qq_id
                          success:(HttpRequestSuccess)success;

// zalo用户绑定手机
+ (void)requestzalobandphone:(NSString *)phone
                    password:(NSString *)password
                 verify_code:(NSString *)verify_code
                     zalo_id:(NSString *)zalo_id
                   zalo_name:(NSString *)zalo_name
                     picture:(NSString *)picture
                      gender:(NSString *)gender
                    birthday:(NSString *)birthday
                     success:(HttpRequestSuccess)success;
//脸书绑定手机
+ (void)requestFbbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     fb_id:(NSString *)fb_id
                   iconurl:(NSString *)iconurl
                   fb_name:(NSString *)fb_name
                   success:(HttpRequestSuccess)success;

//WX绑定手机
+ (void)requestWXbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     wx_id:(NSString *)wx_id
                     wx_unionid:(NSString *)wx_unionid
                   iconurl:(NSString *)iconurl
                   wx_name:(NSString *)wx_name
                   success:(HttpRequestSuccess)success;

//QQ绑定手机
+ (void)requestQQbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     qq_id:(NSString *)qq_id
                   iconurl:(NSString *)iconurl
                   qq_name:(NSString *)qq_name
                   success:(HttpRequestSuccess)success;

//Apple绑定手机
+ (void)requestApplebandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     apple_id:(NSString *)apple_id
                      success:(HttpRequestSuccess)success;

///
/**
 验证手机是否被别人绑定
 1手机号码不存在 2脸书账号未绑定 3zalo未绑定 4均未绑定
 @param phone <#phone description#>
 
 */
+ (void)requestcheckphone:(NSString *)phone
                  success:(HttpRequestSuccess)success;

/**
 忘记密码

 @param phone <#phone description#>
 @param password_new <#password_new description#>
 @param verify_code <#verify_code description#>
 @param success <#success description#>
 */
+ (void)requestforgetpasswordPhone:(NSString *)phone
                      password_new:(NSString *)password_new
                       verify_code:(NSString *)verify_code
                           success:(HttpRequestSuccess)success;
   

/**
 发送号码

 @param phone 电话
 @param status 请求短信类型 1注册 2修改绑定手机号 3登录 4三方软件绑定手机号 5忘记密码
 */
+ (void)requestSmscodePhone:(NSString *)phone
                     status:(NSString *)status
                    success:(HttpRequestSuccess)success;

//修改密码
+ (void)requestRegistPhone:(NSString *)phone
                  password:(NSString *)password
                   andCode:(NSString *)Codel;

+ (void)requestUserinfo;

@end

NS_ASSUME_NONNULL_END
