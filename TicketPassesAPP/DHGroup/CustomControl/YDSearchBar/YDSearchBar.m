//
//  YDSearchBar.m
//  XiaoShunZiAPP
//
//  Created by Mac on 2018/6/5.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import "YDSearchBar.h"

@interface YDSearchBar ()
@property(nonatomic,assign) BOOL isChangeFrame;//是否要改变searchBar的frame
@end

@implementation YDSearchBar

- (void)layoutSubviews {
    

    if ([UIDevice currentDevice].systemVersion.floatValue < 13.0) {
        [super layoutSubviews];
    }
    for (UIView *subView in self.subviews[0].subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]]) {
            
            //移除UISearchBarBackground
            [subView removeFromSuperview];
        }
        
        
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            
            UITextField *textField = self.searchTextField;
            if ([textField isKindOfClass:[UITextField class]]) {
                
                CGFloat height = self.bounds.size.height;
                CGFloat width = self.bounds.size.width;
                
                [textField setBackgroundColor:RGB(246, 246, 246)];
                
                if (_isChangeFrame) {
                    //说明contentInset已经被赋值
                    // 根据contentInset改变UISearchBarTextField的布局
                    textField.frame = CGRectMake(_contentInset.left, _contentInset.top, width - 2 * _contentInset.left, height - 2 * _contentInset.top);
                } else {
                    
                    // contentSet未被赋值
                    // 设置UISearchBar中UISearchBarTextField的默认边距
                    CGFloat top = (height - 28.0) / 2.0;
                    CGFloat bottom = top;
                    CGFloat left = 8.0;
                    CGFloat right = left;
                    _contentInset = UIEdgeInsetsMake(top, left, bottom, right);
                }
            }
            
        } else{
            
            if ([subView isKindOfClass:[UITextField class]]) {
                
                CGFloat height = self.bounds.size.height;
                CGFloat width = self.bounds.size.width;
                
                [subView setBackgroundColor:RGB(246, 246, 246)];
                
                if (_isChangeFrame) {
                    //说明contentInset已经被赋值
                    // 根据contentInset改变UISearchBarTextField的布局
                    subView.frame = CGRectMake(_contentInset.left, _contentInset.top, width - 2 * _contentInset.left, height - 2 * _contentInset.top);
                } else {
                    
                    // contentSet未被赋值
                    // 设置UISearchBar中UISearchBarTextField的默认边距
                    CGFloat top = (height - 28.0) / 2.0;
                    CGFloat bottom = top;
                    CGFloat left = 8.0;
                    CGFloat right = left;
                    _contentInset = UIEdgeInsetsMake(top, left, bottom, right);
                }
            }
            
        }
        
    }
}

#pragma mark - set method
- (void)setContentInset:(UIEdgeInsets)contentInset {
    
    _contentInset.top = contentInset.top;
    _contentInset.bottom = contentInset.bottom;
    _contentInset.left = contentInset.left;
    _contentInset.right = contentInset.right;
    
    self.isChangeFrame = YES;
    [self layoutSubviews];
}

- (void)setIsChangeFrame:(BOOL)isChangeFrame {

    if (_isChangeFrame != isChangeFrame) {

        _isChangeFrame = isChangeFrame;
    }
}

@end
