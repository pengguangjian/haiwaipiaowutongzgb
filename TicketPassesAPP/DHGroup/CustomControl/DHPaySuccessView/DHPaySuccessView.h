//
//  DHPaySuccessView.h
//  NAM BAC THONG
//
//  Created by caochun on 2019/10/16.
//  Copyright © 2019 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PaySuccessViewHandler) (void);

@interface DHPaySuccessView : UIView

@property (nonatomic, copy) PaySuccessViewHandler handler;

+ (instancetype)sharedView;
- (void)show;

@end

NS_ASSUME_NONNULL_END
