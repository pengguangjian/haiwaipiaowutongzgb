//
//  AFHTTP.h
//  xiaoTest
//
//  Created by Xiaoshiheng_pro on 2016/12/10.
//  Copyright © 2016年 xiao_shoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBHTTPClient.h"
#import "XBHTTPClient+XBRequest.h"


@interface AFHTTP : XBHTTPClient

#pragma mark ----------------GET------------------------
/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;


#pragma mark ----------------POST------------------------

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

/**
 *  POST请求,无缓存 带图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param photos     图片数组
 *  @param photoNames 图片数组名称
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */

+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                    photos:(NSArray <UIImage *>*)photos
                photoNames:(NSArray*)photoNames
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;


    
#pragma mark - POST请求上传文件

/**
 POST请求上传文件

 @param URL 请求地址
 @param parameters 请求参数
 @param fileData 要编码的数据并附加到表单数据。
 @param name 与指定数据关联的名称。
 @param fileName 与指定数据相关联的文件名。
 @param fileTye 文件类型
 @param progress 上传进度信息
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancle方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                  fileData:(NSData*)fileData
                      name:(NSString*)name
                  fileName:(NSString*)fileName
                   fileTye:(NSString*)fileTye
                  progress:(HttpProgress)progress
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                 dataArray:(NSArray *)dataArray
                  progress:(HttpProgress)progress
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;



@end
