//
//  XSZNavSliderMenuView.h
//  XiaoShunZiAPP
//
//  Created by Mac on 2019/5/10.
//  Copyright © 2019 XiaoShunZi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSZNavSliderMenuView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, copy)  void(^buttonSelected)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
