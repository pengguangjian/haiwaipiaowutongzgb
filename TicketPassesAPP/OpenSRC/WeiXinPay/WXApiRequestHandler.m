//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "CommonUtil.h"
#import "WXPay.h"



@interface WXApiRequestHandler ()

@end

@implementation WXApiRequestHandler

+(instancetype)sharedRequestHandler {
    static dispatch_once_t onceToken;
    static WXApiRequestHandler *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiRequestHandler alloc] init];
    });
    return instance;
}

- (NSString *)jumpToBizPay:(NSString*)orderNo {

    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary]
//                         objectForKey:@"CFBundleVersion"];
//    
//
//    NSDictionary *dataDic = @{@"order_type":[NSNumber numberWithInt:3],@"order_sn":orderNo};
//    
//    NSArray *returnArr = [Util getRequetInterfaceData:dataDic andInterfaceName:@"pay.wechat.app" andIsLogin:NO];
//    
//    AFHTTPSessionManager *manager = [returnArr objectAtIndex:0];
//    NSURL *URL = [returnArr objectAtIndex:1];
//    NSDictionary *parameters = [[returnArr objectAtIndex:2] copy];
//    
//    [manager POST:URL.absoluteString parameters:parameters progress:^(NSProgress *uploadProgress) {
//        //正在执行请求
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSNumber *status = [responseObject valueForKey:@"status"];
//        if ([status integerValue] == 10000) {
//            NSLog(@"Json:%@",responseObject);
//            
//            NSString *resultStr = [responseObject valueForKey:@"result"];
//            //将接收到token数据转为字典
//            NSData *jsonData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                       options:NSJSONReadingMutableContainers
//                                                                         error:nil];
//            WXPay *wxPay = [WXPay mj_objectWithKeyValues:dictionary];
//            
//            PayReq* req             = [[PayReq alloc] init];
//            req.partnerId           = wxPay.partnerid;
//            req.prepayId            = wxPay.prepayid;
//            req.nonceStr            = wxPay.noncestr;
//            req.timeStamp           = [wxPay.timestamp intValue];
//            req.package             = wxPay._package;
//            req.sign                = wxPay.sign;
//            [WXApi sendReq:req];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"errmsg"]];
//        }
//
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error)
//     {
//         NSLog(@"请求失败:%@",error);
//     }];

    
    
    return nil;

}

- (void)jumpToBizPayWithDic:(NSDictionary *)dic {
    
    HttpManager *hm = [HttpManager createHttpManager];
    
    hm.responseHandler = ^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
            if ([rd.code isEqualToString:SUCCESS]) {
                WXPay *wxPay = [WXPay mj_objectWithKeyValues:rd.data];
                
                PayReq *req             = [[PayReq alloc] init];
                req.partnerId           = wxPay.partnerid;
                req.prepayId            = wxPay.prepayid;
                req.nonceStr            = wxPay.noncestr;
                req.timeStamp           = [wxPay.timestamp intValue];
                req.package             = wxPay.package;
                req.sign                = wxPay.sign;
                [WXApi sendReq:req];
                
            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });
    };
    
    [hm getRequetInterfaceData:dic withInterfaceName:@"/api/orderpay/sendorder"];
    
}

@end
