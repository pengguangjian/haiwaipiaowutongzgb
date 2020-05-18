//
//  XSZContentScrollView.m
//  XiaoShunZiAPP
//
//  Created by Mac on 2019/5/10.
//  Copyright © 2019 XiaoShunZi. All rights reserved.
//

#import "XSZContentScrollView.h"

@implementation XSZContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.clipsToBounds = NO;
    }
    return self;
}



//- (void)setOffset:(CGPoint)offset
//{
//    _offset = offset;
////    NSLog(@"%@", NSStringFromCGPoint(offset));
//}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//
//    UIView* view = [super hitTest:point withEvent:event];
//    BOOL hitHead = point.y < (_HeadViewHeight - self.offset.y);
//    if (hitHead || !view)
//    {
//        NSLog(@"no view");
//        self.scrollEnabled = NO;
//        if (!view)
//        {
//            for (UIView* subView in self.subviews) {
//                if (subView.frame.origin.x == self.contentOffset.x)
//                {
//                    view = subView;
//                }
//            }
//        }
//        return view;
//    }else{
//        NSLog(@"view = %@", view);
//        self.scrollEnabled = YES;
//        return view;
//
//    }
//}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    // 获取一个UITouch
    UITouch *touch = [touches anyObject];
    // 获取当前的位置
    CGPoint current = [touch locationInView:self];
    CGFloat x = [UIScreen mainScreen].bounds.size.width;
    
    //    NSLog(@"current.x:%f, x:%f",current.x, x);
    
    if (current.x >= x + 10) {
        //在地图上
        //        NSLog(@"在地图上, 不滚动, view class is %@", view.class);
        return YES;
    } else {
        return [super touchesShouldBegin:touches withEvent:event inContentView:view];
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    //    NSLog(@"cancle class is %@", view.class);
    if ([view isKindOfClass:NSClassFromString(@"TapDetectingView")]) {
        return NO;
    } else {
        return [super touchesShouldCancelInContentView:view];
    }
}

@end
