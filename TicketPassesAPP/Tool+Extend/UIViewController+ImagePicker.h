//
//  UIViewController+ImagePicker.h
//  lxtxAppBackstage
//
//  Created by com.chetuba on 15/7/16.
//  Copyright (c) 2015年 Lxtx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>
#import "UIAlertController+XBKit.h"

typedef void (^FinishPickingMediaWithInfo)(NSDictionary *info);

@interface UIViewController (ImagePicker)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *  UIImagePickerController
 */
@property (strong,nonatomic) UIImagePickerController *imagePicker;
///打开选择
- (void)openChoiceWithCompleteBlock:(FinishPickingMediaWithInfo)block;
///打开相册
- (void)openSystemAblum;
///打开相机
- (void)openSystemCamera;


@end
