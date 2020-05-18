//
//  AFHTTP+News.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+News.h"

@implementation AFHTTP (News)

+ (void)requestNewslistSuccess:(HttpRequestSuccess)success
                       failure:(HttpRequestFailed)failure{
    NSDictionary *param = [self paramStringWithData:@{}];
    
    [AFHTTP POST:@"api/business_travel/newslist" parameters:param success:^(id responseObject){
        
       
        success ? success(responseObject):nil;
        
        
    } failure:^(NSError *error){
        failure ? failure(error):nil;

    }];
}

+ (void)requestNewsdetailNewsId:(NSString *)news_id
                        success:(HttpRequestSuccess)success{
    NSDictionary *param = [self paramStringWithData:@{@"news_id":news_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/business_travel/newsdetail" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject):nil;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}




@end
