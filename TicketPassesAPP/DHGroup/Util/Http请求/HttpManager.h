//
//  HttpManager.h
//  FitnewAPP
//
//  Created by Yudong on 2016/11/2.
//  Copyright © 2016年 xida. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *    请求结果
 *
 *    @param isSuccess
 */
typedef void (^ResponseHandler)(id responseObject);

@interface HttpManager : NSObject

@property (nonatomic, copy) ResponseHandler responseHandler;

+ (instancetype)createHttpManager;

/**
 *  http请求
 *
 *  @param transactionDataDic 业务数据 字典 没有为nil
 *  @param interfaceName      接口名称字符串
 *
 *  @return nil 通过实现ResponseHandler Block获取返回数据
 */
- (void)getRequetInterfaceData:(NSDictionary *)transactionDataDic
                  withInterfaceName:(NSString *)interfaceName;

@end
