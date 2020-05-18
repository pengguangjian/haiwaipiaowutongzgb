//
//  XBHTTPClient.m
//  YJB
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 肖世恒. All rights reserved.
//

#import "XBHTTPClient.h"
#import <CommonCrypto/CommonDigest.h>

//api_key 这种东西只能写进 .m 文件b防止被反编译
#define API_KEY   @"&key=zdf5788hg855SSFSQ64df"

@implementation XBHTTPClient


#pragma mark - 其他---------
/* 输出http响应的状态码 */
+ (void)showResponseCode:(NSURLResponse *)response {
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"%zi", responseStatusCode);
}
//控件显示百分比,这个随意  写这里 怕忘了
+ (void)updateProgress:(NSProgress*)progress{
    /*
     @property int64_t totalUnitCount;  需要下载文件的总大小
     @property int64_t completedUnitCount; 当前已经下载的大小
     */
    dispatch_async(dispatch_get_main_queue(), ^(void){
        //Run UI Updates
        CGFloat progressf = (CGFloat)progress.completedUnitCount/(CGFloat)(progress.totalUnitCount+1);
        progressf = progressf*100;
        NSString* showStr = [NSString stringWithFormat:@"%0.f%c",progressf,'%'];
        NSLog(@"%@",showStr);
    });
    
    NSLog(@"%lld  %lld",progress.totalUnitCount,progress.completedUnitCount);
}

#pragma mark ----------------加密 拼接参数------------------------

+ (NSDictionary*)paramStringWithData:(NSDictionary*)data{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:data];
    //登录后全部加user_id
    if(SYSIsLogined){
        [dict setObject:[[UserInfo sharedInstance] fetchLoginUserInfo].user_id forKey:@"user_id"];
    }
    //排序
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (NSString *key in dict.allKeys) {
        NSString *paramString = [NSString stringWithFormat:@"%@=%@",key,dict[key]];
        [dataArray addObject:paramString];
    }
    //添加 时间
    NSString *timeStr = [self getNowTimeTimestamp];
    [dataArray addObject:[NSString stringWithFormat:@"time=%@",timeStr]];
    //排序
    NSArray *resultkArrSort = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *arrayString = [resultkArrSort componentsJoinedByString:@"&"];
    NSString *signStr = [NSString stringWithFormat:@"%@%@",arrayString,API_KEY];
    //最后加上 时间和s签名
    [dict setObject:timeStr forKey:@"time"];
    [dict setObject:[self md5_32bit:signStr] forKey:@"sign"];
    return dict;
}
//编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    //    data = "%7B\n%20%20%22userName%22%20%3A%20%22kkk%22%2C\n%20%20%22datetoken%22%20%3A%20%222019-06-23%2018%3A36%3A29%22%2C\n%20%20%22password%22%20%3A%20%22jjj%22\n%7D";
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;

    //    data = "%7B%0A%20%20%22userName%22%20%3A%20%22kkk%22%2C%0A%20%20%22datetoken%22%20%3A%20%222019-06-23%2018%3A32%3A24%22%2C%0A%20%20%22password%22%20%3A%20%22jjj%22%0A%7D";
//    NSString *outputStr = (NSString *)    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
//
//    return outputStr;
    
}
+ (NSString *)DataTOjsonString:(id)object
{
    // Pass 0 if you don't care about the readability of the generated string
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"字典转为json error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+ (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
+ (NSString *)md5_32bit:(NSString *)input {
    //传入参数,转化成char
    const char * str = [input UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(str, (int)strlen(str), md);
    //创建一个可变字符串收集结果
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    //返回一个长度为32的字符串
    return [ret lowercaseString];
}

#pragma mark - 设置AFHTTPSessionManager相关属性
+ (AFHTTPSessionManager*)httpSessionManagerWithBaseUrl:(NSString*)baseUrl Headers:(NSDictionary *)headers{
    
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //设置请求超时时间
    sessionConfiguration.timeoutIntervalForRequest =HTTPTimeoutInterval;
    //设置请求headers
    if (headers) {
        sessionConfiguration.HTTPAdditionalHeaders = headers;
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:sessionConfiguration];
    
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"charset=UTF-8", nil];
    
    return manager;
    
    
}


#pragma ++++++++++++++++++++++++++++++下载功能+++++++++++++++++++++++++
#pragma mark - 下载文件
+ (__kindof NSURLSessionTask *)downloadWithdownloadPath:(NSString *)downloadPath
                                                fileDir:(NSString *)fileDir
                                          progressBlock:(HttpProgress)progress
                                           successBlock:(void(^)(NSString *filePath))success
                                           failureBlock:(HttpRequestFailed)failure
{
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *urlString = [downloadPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        
#if DEBUG
        progress ? progress(downloadProgress) : nil;
        progress ? [self updateProgress:downloadProgress] : nil;
#else
        progress ? progress(downloadProgress) : nil;
#endif
        
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        NSLog(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        failure && error ? failure(error) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}
#pragma ++++++++++++++++++++++++++++++上传功能+++++++++++++++++++++++++
+ (__kindof NSURLSessionTask *)uploadWithServerPath:(NSString *)serverPath
                                            Headers:(NSDictionary *)headers
                                       relativePath:(NSString*)relativePath
                                         parameters:(NSDictionary *)parameters
                                             photos:(NSArray <UIImage *>*)photos
                                         photoNames:(NSArray*)photoNames
                                           progress:(HttpProgress)progress
                                            success:(HttpRequestSuccess)success
                                            failure:(HttpRequestFailed)failure
{
    
    AFHTTPSessionManager *manager = [self httpSessionManagerWithBaseUrl:serverPath Headers:headers];
    return [manager POST:relativePath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        for (NSInteger i = 0; i < photos.count; i++) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(photos[i], 0.3) name:photoNames[i] fileName:[NSString stringWithFormat:@"iosphoto%f%i.jpg", [[NSDate date] timeIntervalSince1970], (int)i] mimeType:@"image/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n预处理链接%@%@",serverPath,relativePath);
        [self handleResponseObject:responseObject successBlock:success failureBlock:failure];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleRequestFailure:error failureBlock:failure];

        
    }];
    
    
    
}

#pragma ++++++++++++++++++++++++++++++上传功能+++++++++++++++++++++++++
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
                                            failure:(HttpRequestFailed)failure
{
    
    AFHTTPSessionManager *manager = [self httpSessionManagerWithBaseUrl:serverPath Headers:headers];
    return [manager POST:relativePath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileTye];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n预处理链接%@%@",serverPath,relativePath);
        [self handleResponseObject:responseObject successBlock:success failureBlock:failure];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleRequestFailure:error failureBlock:failure];
        
        
    }];
    
    
    
}

+ (__kindof NSURLSessionTask *)uploadWithServerPath:(NSString *)serverPath
                                            Headers:(NSDictionary *)headers
                                       relativePath:(NSString*)relativePath
                                         parameters:(NSDictionary *)parameters
                                          dataArray:(NSArray *)dataArray
                                           progress:(HttpProgress)progress
                                            success:(HttpRequestSuccess)success
                                            failure:(HttpRequestFailed)failure
{
    AFHTTPSessionManager *manager = [self httpSessionManagerWithBaseUrl:serverPath Headers:headers];
    return [manager POST:relativePath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSDictionary *dic in dataArray) {
            
            [formData appendPartWithFileData:dic[@"fileData"] name:dic[@"name"] fileName:dic[@"fileName"] mimeType:dic[@"fileTye"]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n预处理链接%@%@",serverPath,relativePath);
        [self handleResponseObject:responseObject successBlock:success failureBlock:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleRequestFailure:error failureBlock:failure];
    }];
}



#pragma mark - 请求处理
#pragma mark - 请求成功,处理响应数据
+ (void)handleResponseObject:(id)responseObject
                successBlock:(HttpRequestSuccess)success
                failureBlock:(HttpRequestFailed)failure{
    
    
    NSLog(@"预处理响应数据 = \n %@",responseObject);
    ///可以在此 处理其他事
    if([responseObject isKindOfClass:[NSDictionary class]]){
//        10000  请求成功
//        10001  请求失败 未知错误
//        10002  签名验证失败
//        10003  请求类型错误
//        10004  参数格式错误
//        10005  请求失败 常规错误
//        10006  参数缺少
//        10007  用户不存在或未登录
//        10008  请求过期
        
        NSDictionary *dict = responseObject;
        NSInteger code = [[dict valueForKey:@"code"]integerValue];
        NSString *msg = [dict valueForKey:@"msg"];
        // 状态 code -1 失败接口
        if(code == 10001){
            //接口失败
            NSLog(@"请求失败 未知错误");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10001]) : nil;
            
        }else if(code == 10000){
            //接口成功
            NSDictionary *data = [dict valueForKey:@"data"];
            success ? success(data) : nil;
        }else if(code == 100011){
            //100011  暂无数据
            NSDictionary *data = @{};
            success ? success(data) : nil;
        }else if(code == 10002){
            NSLog(@"签名验证失败");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10002]) : nil;
        }
        else if(code == 10003){
            NSLog(@"请求类型错误");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10003]) : nil;
        }
        else if(code == 10004){
            NSLog(@"参数格式错误");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10004]) : nil;
        }
        else if(code == 10005){
            NSLog(@"请求失败 常规错误");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10005]) : nil;
        }
        else if(code == 10006){
            NSLog(@"参数缺少");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10006]) : nil;
        }
        else if(code == 10007){
            NSLog(@"用户不存在或未登录");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10007]) : nil;
        }
        else if(code == 10008){
            NSLog(@"请求过期");
            failure ? failure([self requestErrorWithDescription:msg ErrorCode:10008]) : nil;
        }
        else{
            //接口失败
            failure ? failure([self requestErrorWithDescription:[NSString stringWithFormat:@"状态code等于其他失败 %@",msg] ErrorCode:-1]) : nil;
        }
    }else{
        // 请求失败
        failure ? failure([self requestErrorWithDescription:@"接口请求解析错误" ErrorCode:-1]) : nil;
    }
}
#pragma mark -
#pragma mark - 请求失败
+ (void)handleRequestFailure:(NSError*)error
                failureBlock:(HttpRequestFailed)failure{
    NSString *string = nil;
    switch (error.code) {
        case -1001:
            string =@"请求超时";
            break;
        case -1002:
            string = @"连接地址错误";
            break;
        case -1003:
            string =@"未能找到服务器。";
            break;
        case -1004:
            string =@"连接不上服务器";
            break;
        case -1005:
            string =@"网络连接已中断";
            break;
        case -1009:
            string =@"已断开与互联网的连接。";
            break;
        case -1011:
            string = error.localizedDescription ;
            break;
        case -1016:
            string =@"服务内部错误";
            break;
        case 3840:
            string =@"请求接口不完整";
            break;
        default:
            string = [NSString stringWithFormat:@"错误代码%zi",error.code];
            break;
    }
    NSLog(@"请求失败信息 = %@ \nerror = %@",string,error);
    failure ? failure([self requestErrorWithDescription:string ErrorCode:-1]) : nil;
}
#pragma mark -
#pragma mark - 生成错误信息
+ (NSError*)requestErrorWithDescription:(NSString*)description
                            ErrorCode:(NSInteger)errorCode{
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:description};
    
    NSError *error = [NSError errorWithDomain:@"Domain" code:errorCode userInfo:userInfo];
    
    return error;
}

@end
