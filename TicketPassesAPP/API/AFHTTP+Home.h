//
//  AFHTTP+Home.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "AFHTTP.h"


@interface AFHTTP (Home)

//首页轮播
//api/ticket/indexbanner
+ (void)requestIndexbannerSuccess:(HttpRequestSuccess)success;

//首页文章
//api/index/indexarticle
+ (void)requestIndexarticleSuccess:(HttpRequestSuccess)success;
//选择城市
+ (void)requestChoicecitySuccess:(HttpRequestSuccess)success;
//热门城市
+ (void)requestHotcitySuccess:(HttpRequestSuccess)success;
//根据起始地和时间搜索车
+ (void)requestHotcityOrigin_id:(NSString *)origin_id
                    destination:(NSString *)destination
                    setout_time:(NSString *)setout_time
                           page:(NSInteger)page
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure;

@end

