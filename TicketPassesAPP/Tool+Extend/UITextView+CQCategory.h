//
//  UITextView+CQCategory.h
//  PodManager
//
//  Created by 龚魁华 on 2018/7/9.
//  Copyright © 2018年 mn. All rights reserved.
//

#import <UIKit/UIKit.h>
UITextView *cq_textView(void);
@interface UITextView (CQCategory)
@property (nonatomic, readonly) UITextView *placeholderTextView;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@end
