//
//  XBHTTPClient+XBRequest.h
//  YJB
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 肖世恒. All rights reserved.
//

#import "XBHTTPClient.h"

@interface XBHTTPClient (XBRequest)

/**
 功能描述:GET请求
 
 @param serverPath 服务器地址
 @param headers 请求头
 @param relativePath 请求相对路径地址
 @param parameters 请求参数
 @param success 求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)requestGETWithServerPath:(NSString *)serverPath
                                                Headers:(NSDictionary *)headers
                                           relativePath:(NSString*)relativePath
                                             parameters:(NSDictionary *)parameters
                                           successBlock:(HttpRequestSuccess)success
                                           failureBlock:(HttpRequestFailed)failure;


/**
 功能描述:POST请求,自动缓存
 
 @param serverPath 服务器地址
 @param headers 请求头
 @param relativePath 请求相对路径地址
 @param parameters 请求参数
 @param success       请求成功的回调
 @param failure       请求失败的回调
 @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)requestPOSTWithServerPath:(NSString *)serverPath
                                                 Headers:(NSDictionary *)headers
                                            relativePath:(NSString*)relativePath
                                              parameters:(NSDictionary *)parameters
                                            successBlock:(HttpRequestSuccess)success
                                            failureBlock:(HttpRequestFailed)failure;

@end
