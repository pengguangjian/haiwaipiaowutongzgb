//
//  DHSelectSeatView.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/10/25.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DHSelectSeatViewHandler)(NSArray *selectArr);

@interface DHSelectSeatView : UIView

@property (nonatomic, copy) DHSelectSeatViewHandler handler;

/**
 *  创建单例并绘制界面
 *
 *  @return return value instancetype
 */
+ (instancetype)sharedView:(NSString*)tripID;
- (void)show;

@end



NS_ASSUME_NONNULL_END
