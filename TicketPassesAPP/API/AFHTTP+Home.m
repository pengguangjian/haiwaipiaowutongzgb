//
//  AFHTTP+Home.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+Home.h"

@implementation AFHTTP (Home)

//首页轮播
//api/ticket/indexbanner
+ (void)requestIndexbannerSuccess:(HttpRequestSuccess)success{
    NSDictionary *param = [self paramStringWithData:@{}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/ticket/indexbanner" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
    }];
}

//首页文章
//api/index/indexarticle
+ (void)requestIndexarticleSuccess:(HttpRequestSuccess)success{
        
        NSDictionary *param = [self paramStringWithData:@{}];
        
        [AFHTTP POST:@"api/index/indexarticle" parameters:param success:^(id responseObject){
            
            
            success ? success(responseObject) : nil ;
            
        } failure:^(NSError *error){
            
        }];
    }

+ (void)requestChoicecitySuccess:(HttpRequestSuccess)success{

    
    NSDictionary *param = [self paramStringWithData:@{@"country_type":@"3",@"language_type":@"1"}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/ticket/choicecity" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

+ (void)requestHotcitySuccess:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"country_type":@"3"}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/ticket/hotcity" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}
+ (void)requestHotcityOrigin_id:(NSString *)origin_id
                    destination:(NSString *)destination
                    setout_time:(NSString *)setout_time
                           page:(NSInteger)page
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure{

    NSDictionary *param = [self paramStringWithData:@{@"origin_id":origin_id,@"destination":destination,@"setout_time":setout_time,@"page":[NSNumber numberWithInt:page]}];
    
    [AFHTTP POST:@"api/ticket/searchticket" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


@end
