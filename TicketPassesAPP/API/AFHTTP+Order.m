//
//  AFHTTP+Order.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+Order.h"

@implementation AFHTTP (Order)

+ (void)requestAddticketorderStation_begin:(NSString *)station_begin
                               station_end:(NSString *)station_end
                                     price:(NSString *)price
                               setout_time:(NSString *)setout_time
                              count_ticket:(NSString *)count_ticket
                            success:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"station_begin":station_begin,
                                                      @"station_end":station_end,
                                                      @"price":price,
                                                      @"setout_time":setout_time,
                                                      @"count_ticket":count_ticket
                                                      }];
    [MBManager showLoading];
    [AFHTTP POST:@"api/order/addticketorder" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestBookinglistOb_status:(NSString *)ob_status
                           success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"ob_status":ob_status}];
    
    [AFHTTP POST:@"api/ticketorder/getorders" parameters:param success:^(id responseObject){
        
       success ? success(responseObject) : nil ;
       
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestInfoagreementType:(NSString *)type
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"type":type}];
    
    [AFHTTP POST:@"api/user/infoagreement" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestReplyrefundOb_id:(NSString *)ob_id
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure {
    
    NSDictionary *param = [self paramStringWithData:@{@"ob_id":ob_id}];
    
    [AFHTTP POST:@"api/ticketorder/getrefundrule" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}



+ (void)requestsurerefundOrder_id:(NSString *)order_id
                        success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"order_id":order_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/ticketorder/refund" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}






+ (void)requestLogisticslistOl_status:(NSString *)ol_status
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"ol_status":ol_status}];
    
    [AFHTTP POST:@"api/order/logisticslist" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}


+ (void)requestLogisticsReplyrefundOb_id:(NSString *)ob_id
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailed)failure {
    
    NSDictionary *param = [self paramStringWithData:@{@"ob_id":ob_id}];
    
    [AFHTTP POST:@"api/order/getrefundrule" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}



+ (void)requestLogisticssurerefundOrder_id:(NSString *)order_id
                        success:(HttpRequestSuccess)success
{
    
    NSDictionary *param = [self paramStringWithData:@{@"order_id":order_id}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/order/refund" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requestCancelorderOrder_id:(NSString *)order_id
                              success:(HttpRequestSuccess)success
                              failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"order_id":order_id}];
    
    [AFHTTP POST:@"api/order/cancelorder" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}
+ (void)requesPriceestimateOl_luggage_volume:(NSString *)ol_luggage_volume
                           ol_luggage_weight:(NSString *)ol_luggage_weight
                                     success:(HttpRequestSuccess)success
                                     failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"ol_luggage_volume":ol_luggage_volume,@"ol_luggage_weight":ol_luggage_weight}];
    
    [AFHTTP POST:@"api/order/priceestimate" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
//        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

+ (void)requesAddlogisticsorderOl_begin_address:(NSString *)ol_begin_address
                                 ol_end_address:(NSString *)ol_end_address
                            ol_consignment_time:(NSString *)ol_consignment_time
                               ol_luggage_count:(NSString *)ol_luggage_count
                                ol_luggage_name:(NSString *)ol_luggage_name
                              ol_luggage_volume:(NSString *)ol_luggage_volume
                              ol_luggage_weight:(NSString *)ol_luggage_weight
                                     ol_deposit:(NSString *)ol_deposit
                                  ol_tail_money:(NSString *)ol_tail_money
                                        success:(HttpRequestSuccess)success
                                        failure:(HttpRequestFailed)failure{
    
    NSDictionary *param = [self paramStringWithData:@{@"ol_begin_address":ol_begin_address,@"ol_end_address":ol_end_address,@"ol_consignment_time":ol_consignment_time,@"ol_luggage_count":ol_luggage_count,@"ol_luggage_name":ol_luggage_name,@"ol_luggage_volume":ol_luggage_volume,@"ol_luggage_weight":ol_luggage_weight,@"ol_deposit":ol_deposit,@"ol_tail_money":ol_tail_money}];
    
    [AFHTTP POST:@"api/order/addlogisticsorder" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
        failure ? failure(error) : nil ;
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}
    
+ (void)requeslogisticsdetailOrder_id:(NSString *)order_id
                              success:(HttpRequestSuccess)success{
    NSDictionary *param = [self paramStringWithData:@{@"order_id":order_id}];
    
    [MBManager showLoading];
    [AFHTTP POST:@"api/order/logisticsdetail" parameters:param success:^(id responseObject){
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
       [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

    
    
    


@end
