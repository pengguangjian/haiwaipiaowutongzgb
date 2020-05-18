//
//  ShareView.h
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView

///视图
@property (weak, nonatomic) IBOutlet  UIView *mView;
//黑色背景
@property (weak, nonatomic) IBOutlet  UIView *mTableBaseView;

@property (weak, nonatomic) IBOutlet UIButton *but1;
//@property (weak, nonatomic) IBOutlet UIButton *but2;
@property (weak, nonatomic) IBOutlet UIButton *but3;
//
@property (nonatomic, copy) void (^selectSuccessBlock)(UIButton *but);

+ (ShareView *)sharedSingleton;



- (void)showMenu;
    
- (void)hideMenu;

@end

NS_ASSUME_NONNULL_END
