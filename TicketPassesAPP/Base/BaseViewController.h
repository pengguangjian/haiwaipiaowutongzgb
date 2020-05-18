//
//  BaseViewController.h
//  
//
//  Created by 肖世恒 on 2019/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
/**
 *  MJRefresh 方法封装
 */
- (void)endHeaderRefreshing;//结束刷新动画
- (void)endFooterRefreshing;
- (void)endFooterRefreshingWithNoMoreData;//结束动画并设置为没有更多数据
- (void)resetNoMoreData;//普通闲置状态
@end

NS_ASSUME_NONNULL_END
