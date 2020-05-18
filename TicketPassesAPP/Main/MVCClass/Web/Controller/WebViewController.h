//
//  WebViewController.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/11.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : BaseViewController

//1协议 2关于我们 5文章详情 6自带 标题内容
@property (nonatomic,assign) NSInteger webType;

//5文章详情必要
@property (nonatomic,strong) NSString *newsId;

//6自带标题内容 必要
@property (nonatomic,strong) NSString *newsTiele;
@property (nonatomic,strong) NSString *newsContent;



@end

NS_ASSUME_NONNULL_END
