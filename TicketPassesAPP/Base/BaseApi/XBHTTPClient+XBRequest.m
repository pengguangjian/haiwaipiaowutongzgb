//
//  XBHTTPClient+XBRequest.m
//  YJB
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 肖世恒. All rights reserved.
//

#import "XBHTTPClient+XBRequest.h"

@implementation XBHTTPClient (XBRequest)


#pragma mark ----------------基本请求------------------------
#pragma mark - GET请求自动缓存
+ (__kindof NSURLSessionTask *)requestGETWithServerPath:(NSString *)serverPath
                                                Headers:(NSDictionary *)headers
                                           relativePath:(NSString*)relativePath
                                             parameters:(NSDictionary *)parameters
                                           successBlock:(HttpRequestSuccess)success
                                           failureBlock:(HttpRequestFailed)failure
{
    
    
    
    AFHTTPSessionManager *manager = [self httpSessionManagerWithBaseUrl:serverPath Headers:headers];
    
    NSURLSessionDataTask *dataTask = [manager GET:relativePath parameters:parameters progress:^(NSProgress *uploadProgress){
    }success:^(NSURLSessionDataTask *task, id responseObject)
                                      {
                                          // 请求成功 预处理
                NSLog(@"\n预处理链接%@%@",serverPath,relativePath);
                                          [self handleResponseObject:responseObject successBlock:success failureBlock:failure];
                                          
                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          
                                          //请求失败 预处理
                                          [self handleRequestFailure:error failureBlock:failure];
 
                                      }];
    
    return dataTask;
    
}


#pragma mark - POST请求
+ (NSURLSessionTask *)requestPOSTWithServerPath:(NSString *)serverPath
                                        Headers:(NSDictionary *)headers
                                   relativePath:(NSString*)relativePath
                                     parameters:(NSDictionary *)parameters
                                   successBlock:(HttpRequestSuccess)success
                                   failureBlock:(HttpRequestFailed)failure;

{
    
    AFHTTPSessionManager *manager = [self httpSessionManagerWithBaseUrl:serverPath Headers:headers];
    
    NSURLSessionDataTask *dataTask = [manager POST:relativePath parameters:parameters progress:^(NSProgress *uploadProgress){
    }success:^(NSURLSessionDataTask *task, id responseObject)
                                      {
                    NSLog(@"\n预处理链接%@%@",serverPath,relativePath);
                                          [self handleResponseObject:responseObject successBlock:success failureBlock:failure];
                                          
                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                          [self handleRequestFailure:error failureBlock:failure];
                                          
                                          
                                      }];
    
    return dataTask;
    
}





@end
