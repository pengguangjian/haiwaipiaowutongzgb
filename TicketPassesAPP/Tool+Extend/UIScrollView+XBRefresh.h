//
//  UIScrollView+XBRefresh.h
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/16.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PullDown) (void);
typedef void (^PullUp) (void);

@interface UIScrollView (XBRefresh)

/**
 *  下拉刷新
 *
 *  @param pullDownBlock 下拉block
 */
- (void)tableViewPullDown:(PullDown)pullDownBlock;

/**
 *  上拉刷新
 *
 *  @param pullUpBlock 上拉block
 */
- (void)tableViewPullUp:(PullUp)pullUpBlock;

/**
 *  上、下拉刷新
 *
 *  @param pullDownBlock 下拉block
 *  @param pullUpBlock   上拉block
 */
- (void)tableViewPullDown:(PullDown)pullDownBlock
                   pullUp:(PullUp)pullUpBlock;

#pragma mark - Begin Refreshing
/**
 *  头视图开始刷新
 */
- (void)headerBeginRefreshing;

/**
 *  脚视图开始刷新
 */
- (void)footerBeginRefreshing;

#pragma mark - End Refreshing
/**
 *  头视图停止刷新
 */
- (void)headerEndRefreshing;

/**
 *  脚视图停止刷新
 */
- (void)footerEndRefreshing;

/**
 *  都停止刷新
 */
- (void)allEndRefreshing;


- (void)endFooterRefreshingWithNoMoreData;

- (void)resetNoMoreData;

@end


