//
//  UIViewController+ImagePicker.m
//  lxtxAppBackstage
//
//  Created by com.chetuba on 15/7/16.
//  Copyright (c) 2015年 Lxtx. All rights reserved.
//

#define WARNINGCAMER @"该设备没有相机功能"
#define WARNINGABLUM @"没有访问您的照片的权限,请到系统'设置'-'隐私'-'照片'中开启"


#import "UIViewController+ImagePicker.h"


static char keyImagePickerBlock;
static char keyIsRound;
@implementation UIViewController (ImagePicker)

/**
 OC中的关联就是在已有类的基础上添加对象参数。来扩展原有的类，需要引入#import <objc/runtime.h>头文件。关联是基于一个key来区分不同的关联。
 常用函数: objc_setAssociatedObject     设置关联
 objc_getAssociatedObject     获取关联
 objc_removeAssociatedObjects 移除关联
 */

- (UIImagePickerController *)imagePicker{
    
    UIImagePickerController *Picker = objc_getAssociatedObject(self, _cmd);
    
    if (!Picker) {
        Picker = [[UIImagePickerController alloc] init];
        
        Picker.allowsEditing = YES;
        
        Picker.delegate = self;
        
        Picker.navigationBar.tintColor = [UIColor blackColor];
        Picker.navigationBar.barTintColor =  [UIColor whiteColor];
        
        
        objc_setAssociatedObject(self, _cmd, Picker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return Picker;
}

- (void)setImagePicker:(UIImagePickerController *)imagePicker{
    
}
- (void)openChoiceWithCompleteBlock:(FinishPickingMediaWithInfo)block{
    
    if (block) {
        ////移除所有关联
        //objc_removeAssociatedObjects(self);
        /**
         1 创建关联（源对象，关键字，关联的对象和一个关联策略。)
         2 关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
         3 关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。
         */
        objc_setAssociatedObject(self, &keyImagePickerBlock, block, OBJC_ASSOCIATION_COPY);
        
    }
    
    UIAlertController *alertController = [UIAlertController showActionSheetwithTitle:@"请选择方式" Message:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self openSystemCamera];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self openSystemAblum];
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)openSystemAblum
{
    ALAuthorizationStatus  status = [ALAssetsLibrary authorizationStatus];
    if(status == ALAuthorizationStatusRestricted ||
       status == ALAuthorizationStatusDenied)
    {
        
        
        [UIAlertController showAlertwithMessage:WARNINGABLUM withVC:self withBlock:nil];
        

        return;
    }
    
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController: self.imagePicker animated:YES completion:nil];

}
- (void)openSystemCamera
{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        

        [UIAlertController showAlertwithMessage:WARNINGCAMER withVC:self withBlock:nil];
        
        
        return;
    }
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    ///获取关联的对象，通过关键字。
    FinishPickingMediaWithInfo block = objc_getAssociatedObject(self, &keyImagePickerBlock);
    if (block) {
        ///block传值
        block(info);
    }
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
