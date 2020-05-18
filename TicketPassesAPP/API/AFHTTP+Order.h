//
//  AFHTTP+Order.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTP (Order)


/**
 下d车票ddindan

 @param station_begin 开始地址
 @param station_end 随机数地道战
 @param price 单价价格
 @param setout_time 时间
 @param count_ticket 票数
 @param success 完成
 */
+ (void)requestAddticketorderStation_begin:(NSString *)station_begin
                               station_end:(NSString *)station_end
                                     price:(NSString *)price
                               setout_time:(NSString *)setout_time
                              count_ticket:(NSString *)count_ticket
                                   success:(HttpRequestSuccess)success;


/**
 订票订单列表

 @param ob_status 订票订单状态 1未支付 2已支付（未乘车） 3已支付（已乘车） 4取消
 @param success 完成
 @param failure 失败
 */
+ (void)requestBookinglistOb_status:(NSString *)ob_status
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

/**
  申请退款

 @param ob_id 车票订单编号
 @param success 完成
 @param failure 失败
 */
+ (void)requestReplyrefundOb_id:(NSString *)ob_id
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure;


/**
 确认退款

 @param order_id 订单id
 @param success 完成
 @param failure 失败
 */
+ (void)requestsurerefundOrder_id:(NSString *)order_id
                          success:(HttpRequestSuccess)success;


/**
 物流订单列表

 @param ol_status 物流订单状态 订单状态 1未支付 2支付订金（待完成） 3待支付尾款 4已完成
 @param success 完成
 @param failure 失败
 */
+ (void)requestLogisticslistOl_status:(NSString *)ol_status
                              success:(HttpRequestSuccess)success
                              failure:(HttpRequestFailed)failure;
    

/**
 预定

 @param ol_luggage_volume 体积
 @param ol_luggage_weight 重量
 @param success 完成
 @param failure 失败
 */
+ (void)requesPriceestimateOl_luggage_volume:(NSString *)ol_luggage_volume
                               ol_luggage_weight:(NSString *)ol_luggage_weight
                                         success:(HttpRequestSuccess)success
                                         failure:(HttpRequestFailed)failure;

/**

 下物流订单
 
 @param ol_begin_address  出发地地址信息id
 @param ol_end_address  终点地址信息id
 @param ol_consignment_time  托运日期
 @param ol_luggage_count  行李数量
 @param ol_luggage_name  行李名称
 @param ol_luggage_volume  体积
 @param ol_luggage_weight  重量
 @param ol_deposit  订金
 @param ol_tail_money  尾款
 @param success 完成
 @param failure 失败
 */
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
                                        failure:(HttpRequestFailed)failure;

+ (void)requeslogisticsdetailOrder_id:(NSString *)order_id
                          success:(HttpRequestSuccess)success;

/**
 申请退款

@param ob_id 订单编号
@param success 完成
@param failure 失败
*/
+ (void)requestLogisticsReplyrefundOb_id:(NSString *)ob_id
success:(HttpRequestSuccess)success
                                 failure:(HttpRequestFailed)failure;

/**
确认退款

@param order_id 订单id
@param success 完成
@param failure 失败
*/
+ (void)requestLogisticssurerefundOrder_id:(NSString *)order_id
                                   success:(HttpRequestSuccess)success;

@end

NS_ASSUME_NONNULL_END
