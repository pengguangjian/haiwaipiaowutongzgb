//
//  AFHTTP.m
//  xiaoTest
//
//  Created by Xiaoshiheng_pro on 2016/12/10.
//  Copyright © 2016年 xiao_shoubao. All rights reserved.
//

#import "AFHTTP.h"


@implementation AFHTTP

#pragma mark ----------------GET------------------------
#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure{
    NSString *url  = URL;
    NSLog(@" \n请求链接 = %@%@ \n请求参数 = %@" ,HTTPAPI,url,parameters);
    return [self requestGETWithServerPath:HTTPAPI Headers:nil relativePath:url parameters:parameters successBlock:success failureBlock:failure];
    
}


#pragma mark ----------------POST------------------------

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure{
    NSString *url  = URL;
    NSLog(@" \n请求链接 = %@%@ \n请求参数 = %@" ,HTTPAPI,url,parameters);
    return [self requestPOSTWithServerPath:HTTPAPI Headers:nil relativePath:url parameters:parameters successBlock:success failureBlock:failure];
    

    
}

#pragma mark - POST请求无缓存  带图片
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                    photos:(NSArray <UIImage *>*)photos
                photoNames:(NSArray*)photoNames
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure{
    NSString *url  = URL;
    NSLog(@" \n请求链接 = %@%@ \n请求参数 = %@" ,HTTPAPI,url,parameters);
    return [self uploadWithServerPath:HTTPAPI Headers:nil relativePath:url parameters:parameters photos:photos photoNames:photoNames progress:nil success:success failure:failure];
    
    
}

#pragma mark - POST请求上传文件
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                  fileData:(NSData*)fileData
                      name:(NSString*)name
                  fileName:(NSString*)fileName
                   fileTye:(NSString*)fileTye
                  progress:(HttpProgress)progress
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    NSString *url  = URL;
    NSLog(@" \n请求链接 = %@%@ \n请求参数 = %@" ,HTTPAPI,url,parameters);
    return [self uploadWithServerPath:HTTPAPI Headers:nil relativePath:url parameters:parameters fileData:fileData name:name fileName:fileName fileTye:fileTye progress:progress success:success failure:failure];

}

#pragma mark - POST请求上传文件
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                 dataArray:(NSArray *)dataArray
                  progress:(HttpProgress)progress
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    NSString *url  = URL;
    NSLog(@" \n请求链接 = %@%@ \n请求参数 = %@" ,HTTPAPI,url,parameters);
    return [self uploadWithServerPath:HTTPAPI Headers:nil relativePath:url parameters:parameters dataArray:dataArray progress:progress success:success failure:failure];
    
}




@end
