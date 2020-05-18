//
//  AFHTTP+Login.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+Login.h"

@implementation AFHTTP (Login)

+ (void)requestPasswordLoginPhone:(NSString *)phone
                          password:(NSString *)password{
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"password":password}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/login/passwordlogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"userinfo"]];
        [[UserInfo sharedInstance] updateLoginUserInfo:model];
        
        [XBUtils SYSLogInRootController];
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}
    
    
    
+ (void)requestLoginPhone:(NSString *)phone
                  andCode:(NSString *)Code{
    
    
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"verify_code":Code}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/login/userlogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"userinfo"]];
        [[UserInfo sharedInstance] updateLoginUserInfo:model];
        
        [XBUtils SYSLogInRootController];
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

//zalo检查登录
+ (void)requestZalologinzalo_id:(NSString *)zalo_id
                        success:(HttpRequestSuccess)success
{
    
    
    NSDictionary *param = [self paramStringWithData:@{@"zalo_id":zalo_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/zalologin/checklogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        NSInteger  status = [responseObject[@"status"] integerValue];
        if(status == 1){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


//WX检查登录
+ (void)requestWXloginwx_id:(NSString *)wx_id
                          success:(HttpRequestSuccess)success
{
                              
                              NSDictionary *param = [self paramStringWithData:@{@"wx_id":wx_id}];
                              [MBManager showLoading];
                              [AFHTTP POST:@"api/wxlogin/checklogin" parameters:param success:^(id responseObject){
                                  
                                  [MBManager hideAlert];
                                  
                                  NSInteger  status = [responseObject[@"status"] integerValue];
                                  if(status == 1){
                                      
                                      UserModel *model = [[UserModel alloc]init];
                                      model.ID = responseObject[@"user_id"];
                                      model.user_id = responseObject[@"user_id"];
                                      [[UserInfo sharedInstance] updateLoginUserInfo:model];
                                      
                                      [AFHTTP requestUserinfo];
                                      
                                  }else{
                                      success ? success(responseObject) : nil ;
                                  }
                              
                              } failure:^(NSError *error){
                                  [MBManager hideAlert];
                                  [MBManager showBriefAlert:error.localizedDescription];
                              }];
                          }

//QQ检查登录
+ (void)requestQQloginqq_id:(NSString *)qq_id
                          success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"qq_id":qq_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/qqlogin/checklogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        NSInteger  status = [responseObject[@"status"] integerValue];
        if(status == 1){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
    
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


//apple检查登录
+ (void)requestAppleloginApple_id:(NSString *)apple_id
                          success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"apple_id":apple_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/applelogin/checklogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        NSInteger  status = [responseObject[@"status"] integerValue];
        if(status == 1){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
    
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


//脸书检查登录
+ (void)requestFacebookloginfb_id:(NSString *)fb_id
                          success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"fb_id":fb_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/facebooklogin/checklogin" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        NSInteger  status = [responseObject[@"status"] integerValue];
        if(status == 1){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
    
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

// zalo用户绑定手机
+ (void)requestzalobandphone:(NSString *)phone
                    password:(NSString *)password
                 verify_code:(NSString *)verify_code
                     zalo_id:(NSString *)zalo_id
                   zalo_name:(NSString *)zalo_name
                     picture:(NSString *)picture
                      gender:(NSString *)gender
                    birthday:(NSString *)birthday
                     success:(HttpRequestSuccess)success
{
    
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"phone":phone,
                                                                                    @"verify_code":verify_code,
                                                                                    @"zalo_id":zalo_id,
                                                                                    @"zalo_name":zalo_name,
                                                                                    @"picture":picture,
                                                                                    @"gender":gender,
                                                                                    @"birthday":birthday
                                                                                    }];
    if(![XBUtils isValString:password]){
        [tempdic setValue:password forKey:@"password"];
    }
    
    NSDictionary *param = [self paramStringWithData:tempdic];
    
    [MBManager showLoading];
    [AFHTTP POST:@"api/zalologin/zalobandphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        NSString  *user_id = responseObject[@"user_id"];
        if(![XBUtils isValString:user_id]){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

//WX绑定手机
+ (void)requestWXbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     wx_id:(NSString *)wx_id
                wx_unionid:(NSString *)wx_unionid
                   iconurl:(NSString *)iconurl
                   wx_name:(NSString *)wx_name
                   success:(HttpRequestSuccess)success
{
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"phone":phone,
                                                                                    @"verify_code":verify_code,
                                                                                    @"wx_id":wx_id,
                                                                                    @"wx_unionid":wx_unionid,
                                                                                    @"iconurl":iconurl,
                                                                                    @"wx_name":wx_name,
                                                                                    }];
    if(![XBUtils isValString:password]){
        [tempdic setValue:password forKey:@"password"];
    }
    
    
    NSDictionary *param = [self paramStringWithData:tempdic];
    [MBManager showLoading];
    [AFHTTP POST:@"api/wxlogin/wxbandphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        NSString  *user_id = responseObject[@"user_id"];
        if(![XBUtils isValString:user_id]){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

//QQ绑定手机
+ (void)requestQQbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     qq_id:(NSString *)qq_id
                   iconurl:(NSString *)iconurl
                   qq_name:(NSString *)qq_name
                   success:(HttpRequestSuccess)success
{
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"phone":phone,
                                                                                    @"verify_code":verify_code,
                                                                                    @"qq_id":qq_id,
                                                                                    @"iconurl":iconurl,
                                                                                    @"qq_name":qq_name,
                                                                                    }];
    if(![XBUtils isValString:password]){
        [tempdic setValue:password forKey:@"password"];
    }
    
    
    NSDictionary *param = [self paramStringWithData:tempdic];
    [MBManager showLoading];
    [AFHTTP POST:@"api/qqlogin/qqbandphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        NSString  *user_id = responseObject[@"user_id"];
        if(![XBUtils isValString:user_id]){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

//Apple绑定手机
+ (void)requestApplebandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     apple_id:(NSString *)apple_id
                   success:(HttpRequestSuccess)success
{
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"phone":phone,
                                                                                    @"verify_code":verify_code,
                                                                                    @"apple_id":apple_id
                                                                                    }];
    if(![XBUtils isValString:password]){
        [tempdic setValue:password forKey:@"password"];
    }
    
    
    NSDictionary *param = [self paramStringWithData:tempdic];
    [MBManager showLoading];
    [AFHTTP POST:@"api/applelogin/applebandphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        NSString  *user_id = responseObject[@"user_id"];
        if(![XBUtils isValString:user_id]){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

//脸书绑定手机
+ (void)requestFbbandphone:(NSString *)phone
                  password:(NSString *)password
               verify_code:(NSString *)verify_code
                     fb_id:(NSString *)fb_id
                   iconurl:(NSString *)iconurl
                   fb_name:(NSString *)fb_name
                   success:(HttpRequestSuccess)success
{
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"phone":phone,
                                                                                    @"verify_code":verify_code,
                                                                                    @"fb_id":fb_id,
                                                                                    @"iconurl":iconurl,
                                                                                    @"fb_name":fb_name,
                                                                                    }];
    if(![XBUtils isValString:password]){
        [tempdic setValue:password forKey:@"password"];
    }
    
    
    NSDictionary *param = [self paramStringWithData:tempdic];
    [MBManager showLoading];
    [AFHTTP POST:@"api/facebooklogin/fbbandphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        NSString  *user_id = responseObject[@"user_id"];
        if(![XBUtils isValString:user_id]){
            
            UserModel *model = [[UserModel alloc]init];
            model.ID = responseObject[@"user_id"];
            model.user_id = responseObject[@"user_id"];
            [[UserInfo sharedInstance] updateLoginUserInfo:model];
            
            [AFHTTP requestUserinfo];
            
        }else{
            success ? success(responseObject) : nil ;
        }
        
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}
//验证手机是否被别人绑定
+ (void)requestcheckphone:(NSString *)phone
                  success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone}];
    [MBManager showLoading];
                   
    [AFHTTP POST:@"api/login/checkphone" parameters:param success:^(id responseObject){
        //1手机号码不存在 2脸书账号未绑定 3zalo未绑定 4均未绑定
        [MBManager hideAlert];
         success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


    
+ (void)requestforgetpasswordPhone:(NSString *)phone
                         password_new:(NSString *)password_new
                    verify_code:(NSString *)verify_code
                        success:(HttpRequestSuccess)success{
        
        NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"password_new":password_new,@"verify_code":verify_code}];
        [MBManager showLoading];
        [AFHTTP POST:@"api/login/forgetpassword" parameters:param success:^(id responseObject){
            
            [MBManager hideAlert];
            success ? success(responseObject) : nil ;
            
        } failure:^(NSError *error){
            [MBManager hideAlert];
            [MBManager showBriefAlert:error.localizedDescription];
        }];
        
    }
    

+ (void)requestSmscodePhone:(NSString *)phone
                     status:(NSString *)status
                    success:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"status":status}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/login/smscode" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"发送成功"];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestRegistPhone:(NSString *)phone
                  password:(NSString *)password
                   andCode:(NSString *)Code{
    
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"password":password,@"verify_code":Code}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/login/userregist" parameters:param success:^(id responseObject){

        [MBManager hideAlert];
        UserModel *model = [[UserModel alloc]init];
        model.ID = responseObject[@"user_id"];
        model.user_id = responseObject[@"user_id"];
        [[UserInfo sharedInstance] updateLoginUserInfo:model];
        
        [AFHTTP requestUserinfo];
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}
+ (void)requestUserinfo{
    
    NSDictionary *param = [self paramStringWithData:@{}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/userinfo" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"userinfo"]];
        [[UserInfo sharedInstance] updateLoginUserInfo:model];
        
        [XBUtils SYSLogInRootController];
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}




@end
