//
//  TYStarRateView.h
//  TuYouAPP
//
//  Created by caochun on 15/6/23.
//
//

#import <UIKit/UIKit.h>

@class TYStarRateView;
@protocol TYStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(TYStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface TYStarRateView : UIView

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL isSetting;//是否允许设置评分，默认为YES

@property (nonatomic, weak) id<TYStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
