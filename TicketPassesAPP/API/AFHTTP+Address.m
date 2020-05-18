//
//  AFHTTP+Address.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/18.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+Address.h"

@implementation AFHTTP (Address)

+ (void)requestMyaddressSuccess:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{}];
    
    [AFHTTP POST:@"api/logistics/myaddress" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}


+ (void)requestMyaddressAd_consignee:(NSString *)ad_consignee
                  ad_consignee_phone:(NSString *)ad_consignee_phone
                      ad_get_address:(NSString *)ad_get_address
                             success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"ad_consignee":ad_consignee,@"ad_consignee_phone":ad_consignee_phone,@"ad_get_address":ad_get_address}];
    
    [MBManager showLoading];
    [AFHTTP POST:@"api/logistics/createaddress" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}


+ (void)requestEditaddressAd_id:(NSString *)ad_id
                   ad_consignee:(NSString *)ad_consignee
             ad_consignee_phone:(NSString *)ad_consignee_phone
                 ad_get_address:(NSString *)ad_get_address
                        success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"ad_id":ad_id,@"ad_consignee":ad_consignee,@"ad_consignee_phone":ad_consignee_phone,@"ad_get_address":ad_get_address}];
    
    [MBManager showLoading];
    [AFHTTP POST:@"api/logistics/editaddress" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestDeladdressAd_id:(NSString *)ad_id
                       success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"ad_id":ad_id}];
    
    [MBManager showLoading];
    [AFHTTP POST:@"api/logistics/deladdress" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}






@end
