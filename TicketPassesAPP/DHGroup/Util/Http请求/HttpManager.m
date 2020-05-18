//
//  HttpManager.m
//  FitnewAPP
//
//  Created by Yudong on 2016/11/2.
//  Copyright © 2016年 xida. All rights reserved.
//

#import "HttpManager.h"
#import <CommonCrypto/CommonDigest.h>

//api_key 这种东西只能写进 .m 文件b防止被反编译
#define API_KEY   @"&key=zdf5788hg855SSFSQ64df"

@implementation HttpManager

+ (instancetype)createHttpManager {
    
    return [[HttpManager alloc] init];
}

- (void)getRequetInterfaceData:(NSDictionary *)transactionDataDic
                   withInterfaceName:(NSString *)interfaceName {
    
    
    transactionDataDic = [self paramStringWithData:transactionDataDic];
    
    //将业务数据的字典转化为Json串
    NSString *dataStr = nil;
    if (transactionDataDic) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:transactionDataDic
                                                           options:NSJSONWritingPrettyPrinted error:nil];
        dataStr = [[NSString alloc]initWithData:jsonData
                                       encoding:NSUTF8StringEncoding];
    }
    
    //URL组拼
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HTTPAPI, interfaceName];
    NSURL *URL = [NSURL URLWithString:urlStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //添加可接受数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 100.0f;
    
//    if ([User sharedUser].token.length>0) {
//        [manager.requestSerializer setValue:[User sharedUser].token forHTTPHeaderField:@"token"];
//    }
//    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"device"];
//    [manager.requestSerializer setValue:[Util getUDID] forHTTPHeaderField:@"deviceid"];
//    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"systemos"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if (dataStr) {
        NSLog(@"%@  %@",interfaceName, dataStr);
        [parameters setObject:dataStr forKey:@"data"];
    } else {
        parameters = nil;
    }
    
    [manager POST:URL.absoluteString parameters:transactionDataDic progress:^(NSProgress *uploadProgress) {
        //正在执行请求
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];
        
        if (self.responseHandler) {
            self.responseHandler(responseObject);
        }

        NSLog(@"success %@",interfaceName);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"failure %@",interfaceName);

     }];
}


#pragma mark ----------------加密 拼接参数------------------------

- (NSDictionary*)paramStringWithData:(NSDictionary*)data{
    
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
- (NSString *)encodeToPercentEscapeString: (NSString *) input

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

- (NSString *)DataTOjsonString:(id)object
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

- (NSString *)getNowTimeTimestamp{
    
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

- (NSString *)md5_32bit:(NSString *)input {
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



@end
