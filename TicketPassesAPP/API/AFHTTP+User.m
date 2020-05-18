//
//  AFHTTP+User.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/13.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP+User.h"

@implementation AFHTTP (User)


//上传头像
+ (void)requestUpdateimage:(UIImage * )image
                       Success:(HttpRequestSuccess)success{
    
    
    //时间戳加iosheader
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*fileName = [NSString stringWithFormat:@"%0.fiosheader.jpg", a];//转为字符型
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSDictionary *param = [self paramStringWithData:@{}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/updateimage" parameters:param fileData:imageData name:@"file" fileName:fileName fileTye:@"image/jpg" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error) {
        
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    

}

+ (void)requestInfoagreementSuccess:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/business_travel/shareintro" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}


+ (void)requestInfoagreementType:(NSInteger)type
                         success:(HttpRequestSuccess)success{
    
    NSString *typestr = [NSString stringWithFormat:@"%zi",type];
    NSDictionary *param = [self paramStringWithData:@{@"type":typestr}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/infoagreement" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}
+ (void)requestInfoagreement333333success:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"type":@"3"}];
    
    [AFHTTP POST:@"api/user/infoagreement" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
    }];
    
}

+ (void)requestInfoagreement444444success:(HttpRequestSuccess)success {
    
    NSDictionary *param = [self paramStringWithData:@{@"type":@"4"}];
    
    [AFHTTP POST:@"api/user/infoagreement" parameters:param success:^(id responseObject){
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error) {
        
    }];
    
}


+ (void)requestInfoagreement555555success:(HttpRequestSuccess)success {
    
    NSDictionary *param = [self paramStringWithData:@{@"type":@"4"}];
    
    [AFHTTP POST:@"api/user/infoagreement" parameters:param success:^(id responseObject) {
        
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        
    }];
    
}

+ (void)requestUpdateuinfoNickname:(NSString *)nickname
                           success:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"nickname":nickname}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/updateuinfo" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        //更新 数据
        [AFHTTP requestUserinfoSuccess:success];
       
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}
+ (void)requestUserinfoSuccess:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/userinfo" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        
        UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"userinfo"]];
        [[UserInfo sharedInstance] updateLoginUserInfo:model];
        
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}


+ (void)requestBandnewphonePhone:(NSString *)phone
                     verify_code:(NSString *)verify_code
                         success:(HttpRequestSuccess)success{
    
    NSDictionary *param = [self paramStringWithData:@{@"phone":phone,@"verify_code":verify_code}];
    [MBManager showLoading];
    [AFHTTP POST:@"api/user/bandnewphone" parameters:param success:^(id responseObject){
        
        [MBManager hideAlert];
        success ? success(responseObject) : nil ;
        
    } failure:^(NSError *error){
        [MBManager hideAlert];
        [MBManager showBriefAlert:error.localizedDescription];
    }];
}

@end
