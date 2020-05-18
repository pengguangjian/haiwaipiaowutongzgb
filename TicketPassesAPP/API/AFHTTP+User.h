//
//  AFHTTP+User.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTP (User)

//上传头像
+ (void)requestUpdateimage:(UIImage * )image
                   Success:(HttpRequestSuccess)success;

//分享
+ (void)requestInfoagreementSuccess:(HttpRequestSuccess)success;

+ (void)requestInfoagreement333333success:(HttpRequestSuccess)success;
+ (void)requestInfoagreement444444success:(HttpRequestSuccess)success;
+ (void)requestInfoagreement555555success:(HttpRequestSuccess)success;
/**
 协议

 @param type 请求数据类型 1协议 2关于我们 3预定须知 4退款说明
 @param success 请求成功
 */
+ (void)requestInfoagreementType:(NSInteger)type
                         success:(HttpRequestSuccess)success;


+ (void)requestUpdateuinfoNickname:(NSString *)nickname
                           success:(HttpRequestSuccess)success;

+ (void)requestBandnewphonePhone:(NSString *)phone
                     verify_code:(NSString *)verify_code
                         success:(HttpRequestSuccess)success;

@end

NS_ASSUME_NONNULL_END
