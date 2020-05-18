//
//  UIViewController+SBKit.m
//  szshoubao
//
//  Created by xiao_shoubao on 16/6/13.
//  Copyright © 2016年 YQLshoubao. All rights reserved.
//
 
#import "UIViewController+XBKit.h"

#define kMaxItemSize [UIFont systemFontOfSize:15]

@implementation UIViewController (XBKit)


//用替换方法来改变 返回 按钮的样式
+ (void)load
{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(XBKitviewDidLoad));
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    });
    
}



- (void)XBKitviewDidLoad
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}
#pragma ##############################################################


- (void)addRightBarButton:(NSString *)name{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton:)];
    
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, kMaxItemSize, NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=rightButton;
}
- (void)addRightBarButtonImage:(UIImage *)image{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton:)];
    self.navigationItem.rightBarButtonItem=rightButton;
}
- (void)addRightBarButtonSystemItem:(UIBarButtonSystemItem)systemItem{
    
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem target:self action:@selector(clickRightBarButton:)];
    
    
    
    
    self.navigationItem.rightBarButtonItem=rightButton;
}
/*
 *  点击事件
 */
- (void)clickRightBarButton:(UIButton *)sender{
    NSLog(@"请在对应的控制器里重写此方法,clickRightBarButton");
}

//----------------------------------------------------------------------------------------
- (void)addLeftBarButton:(NSString *)name{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarButton:)];
    
    [leftBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, kMaxItemSize, NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
}

- (void)addLeftBarButtonImage:(UIImage *)image{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarButton:)];
    self.navigationItem.leftBarButtonItem=leftBarButton;
}
- (void)addLeftBarButtonSystemItem:(UIBarButtonSystemItem)systemItem{
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem target:self action:@selector(clickLeftBarButton:)];
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
}


- (void)clickLeftBarButton:(UIButton *)sender{
    NSLog(@"请在对应的类里重写此方法,clickLeftBarButton");
}

#pragma +++++++++++++++++++监听键盘+++++++++++++++++++++
/*  监听键盘
 *
 */
- (void)addKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeKeyBoard{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
/*
 *      键盘出来
 */
- (void)keyboardWillShow: (NSNotification *)notification
{
    DLog(@"键盘出来keyboardWillShow,记住移除通知监听removeKeyBoard");
}
/*
 *      键盘隐藏
 */
- (void)keyboardWillHide: (NSNotification *)notification
{
    DLog(@"键盘隐藏keyboardWillHide,记住移除通知监听removeKeyBoard");
}

#pragma +++++++++++++++++++返回上一层+++++++++++++++++++++

-(void)onBack{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark *** 获取当前控制器 ***


- (UIViewController *)ToViewController{
    
    @try {
        
        UIViewController *object=[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        return object;
        
    }@catch (NSException *exception) {
        NSLog(@"Stack Trace: %@", [exception name]);
        DLog(@"viewControllers数量请检查");
        return nil;
    }
    
    
}



- (UIViewController *)ToViewControllerNumber:(NSInteger)number{
    
    @try {
        
        UIViewController *object=[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-1-number];
        return object;
        
    }@catch (NSException *exception) {
        NSLog(@"Stack Trace: %@", [exception name]);
        DLog(@"viewControllers数量请检查");
        return nil;
    }
    
    
}


- (UIViewController *)ToViewControllerName:(NSString *)strClassName{
    
    @try {
        
        Class cls = NSClassFromString(strClassName);
        
        NSArray *array = self.navigationController.viewControllers;
        
        
        for(NSInteger i = [array count];i>0;i--){
            UIViewController *controller = [array objectAtIndex:i-1];
            
            if (([controller isKindOfClass:[cls class]])) {
                
                UIViewController *object= controller;
                
                return object;
                
            }
            
        }
        return nil;
        
    }@catch (NSException *exception) {
        
        NSLog(@"Stack Trace: %@", [exception name]);
        DLog(@"viewControllers数量请检查");
        return nil;
    }

}


- (NSArray *)lookingViewControllers{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    UIViewController *vc = self.presentingViewController;
    [array addObject:vc];
    if (!vc.presentingViewController) {
        return array;
    }
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
        [array addObject:vc];
    }
    return array;
}



@end
