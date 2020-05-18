
//
//  UIScrollView+XBRefresh.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/16.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "UIScrollView+XBRefresh.h"

@implementation UIScrollView (XBRefresh)


#pragma mark - Refresh
- (void)tableViewPullDown:(PullDown)pullDownBlock {
    
    self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pullDownBlock();
    }];
    
}

- (void)tableViewPullUp:(PullUp)pullUpBlock{
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pullUpBlock();
    }];
}

- (void)tableViewPullDown:(PullDown)pullDownBlock
                   pullUp:(PullUp)pullUpBlock {
    
    self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pullDownBlock();
    }];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pullUpBlock();
    }];
}

#pragma mark - Begin Refreshing
//头视图开始刷新
- (void)headerBeginRefreshing {
    [self.mj_header beginRefreshing];
}

//脚视图开始刷新
- (void)footerBeginRefreshing {
    [self.mj_footer beginRefreshing];
}

#pragma mark - End Refreshing
- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
    
}

- (void)allEndRefreshing {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)endFooterRefreshingWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    [self.mj_footer resetNoMoreData];
}

@end
