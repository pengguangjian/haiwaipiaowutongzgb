//
//  AFHTTP+Address.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/18.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTP (Address)


+ (void)requestMyaddressSuccess:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure;

+ (void)requestMyaddressAd_consignee:(NSString *)ad_consignee
                  ad_consignee_phone:(NSString *)ad_consignee_phone
                      ad_get_address:(NSString *)ad_get_address
                             success:(HttpRequestSuccess)success;

+ (void)requestEditaddressAd_id:(NSString *)ad_id
                   ad_consignee:(NSString *)ad_consignee
             ad_consignee_phone:(NSString *)ad_consignee_phone
                 ad_get_address:(NSString *)ad_get_address
                        success:(HttpRequestSuccess)success;

+ (void)requestDeladdressAd_id:(NSString *)ad_id
                       success:(HttpRequestSuccess)success;

@end

NS_ASSUME_NONNULL_END
