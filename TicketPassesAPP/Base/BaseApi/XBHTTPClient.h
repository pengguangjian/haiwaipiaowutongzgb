//
//  XBHTTPClient.h
//  YJB
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 肖世恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);


@interface XBHTTPClient : NSObject


#pragma mark ----------------其他方法------------------------

+ (void)showResponseCode:(NSURLResponse *)response;

+ (void)updateProgress:(NSProgress*)progress;

#pragma mark ----------------加密 拼接参数------------------------

+ (NSString *)md5_32bit:(NSString *)input ;

+ (NSDictionary*)paramStringWithData:(NSDictionary*)data;

#pragma mark ----------------基本请求------------------------

/**
 创建 请求

 @param baseUrl 域名
 @param headers 请求头
 @return 请求对象
 */
+ (AFHTTPSessionManager*)httpSessionManagerWithBaseUrl:(NSString*)baseUrl Headers:(NSDictionary *)headers;


/**
 请求预处理

 @param responseObject 数据
 @param success 成功
 @param failure 错误
 */
+ (void)handleResponseObject:(id)responseObject
                successBlock:(HttpRequestSuccess)success
                failureBlock:(HttpRequestFailed)failure;


/**
 错误

 @param error 错误信息
 @param failure 错误
 */
+ (void)handleRequestFailure:(NSError*)error
                failureBlock:(HttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param downloadPath  下载请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithdownloadPath:(NSString *)downloadPath
                                                fileDir:(NSString *)fileDir
                                          progressBlock:(HttpProgress)progress
                                           successBlock:(void(^)(NSString *filePath))success
                                           failureBlock:(HttpRequestFailed)failure;

/**
 *  上传图片文件
 *
 *  @param serverPath 服务器地址
 *  @param headers 请求头
 *  @param relativePath 请求相对路径地址
 *  @param parameters 请求参数
 *  @param photos     图片数组
 *  @param photoNames       文件对应服务器上的字段
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)uploadWithServerPath:(NSString *)serverPath
                                            Headers:(NSDictionary *)headers
                                       relativePath:(NSString*)relativePath
                                         parameters:(NSDictionary *)parameters
                                             photos:(NSArray <UIImage *>*)photos
                                         photoNames:(NSArray*)photoNames
                                           progress:(HttpProgress)progress
                                            success:(HttpRequestSuccess)success
                                            failure:(HttpRequestFailed)failure;


/**
 上传文件

 @param serverPath 服务器地址
 @param headers 请求头
 @param relativePath 请求相对路径地址
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
+ (__kindof NSURLSessionTask *)uploadWithServerPath:(NSString *)serverPath
                                            Headers:(NSDictionary *)headers
                                       relativePath:(NSString*)relativePath
                                         parameters:(NSDictionary *)parameters
                                           fileData:(NSData*)fileData
                                               name:(NSString*)name
                                           fileName:(NSString*)fileName
                                            fileTye:(NSString*)fileTye
                                           progress:(HttpProgress)progress
                                            success:(HttpRequestSuccess)success
                                            failure:(HttpRequestFailed)failure;


/**
 上传文件
 
 @param serverPath 服务器地址
 @param headers 请求头
 @param relativePath 请求相对路径地址
 @param parameters 请求参数
 @param dataArray 文件集合
  fileData 要编码的数据并附加到表单数据。
  name 与指定数据关联的名称。
  fileName 与指定数据相关联的文件名。
  fileTye 文件类型

 @param progress 上传进度信息
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)uploadWithServerPath:(NSString *)serverPath
                                            Headers:(NSDictionary *)headers
                                       relativePath:(NSString*)relativePath
                                         parameters:(NSDictionary *)parameters
                                          dataArray:(NSArray *)dataArray
                                           progress:(HttpProgress)progress
                                            success:(HttpRequestSuccess)success
                                            failure:(HttpRequestFailed)failure;



@end
