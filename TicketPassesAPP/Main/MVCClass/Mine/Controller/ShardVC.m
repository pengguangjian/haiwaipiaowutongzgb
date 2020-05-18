//
//  ShardVC.m
//  TicketPassesAPP
//
//  Created by xiaoshiheng on 2019/8/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "ShardVC.h"
#import "UIImage+XBKit.h"
#import <Photos/Photos.h>
#import "ShareView.h"
#import "YDShareView.h"
@interface ShardVC ()
@property (weak, nonatomic) IBOutlet UIImageView *rwmImageView;
@property (weak, nonatomic) IBOutlet UILabel *shouming;

@property (nonatomic,strong) UIImage *erweimaimag;

@property (nonatomic,strong) ShareView *shareview;

@end

@implementation ShardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSBundleLocalizedString(@"我的分享");
    
    
    [self addRightBarButton:@"分享"];
    
    self.shouming.numberOfLines = 0;
    NSString *rwmrl = [NSString stringWithFormat:@"%@d1/index.html",HTTPAPI];

   UIImage *erweimaimag = [UIImage qrImageWithString:rwmrl size:CGSizeMake(200, 200) color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
    
    self.rwmImageView.image = erweimaimag;
    
    
    [self requestInfoagreement];
}

-(void)clickRightBarButton:(UIButton *)sender{
    
//    [self.shareview showMenu];
    
    
    YDShareView *shareView = [YDShareView sharedView];
    shareView.title = @"";//title;
    shareView.image = [UIImage imageNamed:@"logosearch"];
    shareView.url = @"http://ticket.dottp.com/download.html";
    shareView.content = @"http://ticket.dottp.com";//content;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:shareView];
    [shareView show];
    
}

- (IBAction)baocunClick:(id)sender {

    UIImage *screenimage =  [self screenShot];
    NSData *iamge = UIImagePNGRepresentation(screenimage);
    [self savePhotoWithData:iamge completion:^(NSError *error){
        if (error) {
            [MBManager showBriefAlert:@"保存失败"];
        }else{
            [MBManager showBriefAlert:@"成功保存到相册"];
        }
    }];    
    
}
- (UIImage *)screenShot {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT), NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotImage;
}
- (void)requestInfoagreement{
    
    WEAK_SELF;
    [AFHTTP requestInfoagreementSuccess:^(id responseObject) {
        NSDictionary *dic =responseObject[@"textdata"];
        if([dic isKindOfClass:[NSDictionary class]]){
            weakSelf.shouming.text = dic[@"content"];
        }
    }];
}

- (void)savePhotoWithData:(NSData *)data completion:(void (^)(NSError *error))completion {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        options.shouldMoveFile = YES;
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        [request addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
        request.creationDate = [NSDate date];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (success && completion) {
                completion(nil);
            } else if (error) {
                NSLog(@"保存照片出错:%@",error.localizedDescription);
                if (completion) {
                    completion(error);
                }
            }
        });
    }];
}

- (ShareView *)shareview{
    if(!_shareview){
        _shareview = [ShareView sharedSingleton];
        WEAK_SELF;
        [_shareview setSelectSuccessBlock:^(UIButton * _Nonnull sender) {
            if(sender.tag == 101){
                UMSocialPlatformType type = UMSocialPlatformType_Facebook;
                // 分享消息
                UMSocialMessageObject *message = [UMSocialMessageObject messageObject];
                // 网页内容
                //        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
                UIImage *image = [UIImage imageNamed:@"logosearch"];
                NSData *data = UIImagePNGRepresentation(image);
                UMShareWebpageObject *shareWeb = [UMShareWebpageObject shareObjectWithTitle:@""
                                                                                      descr:@""
                                                                                  thumImage:data];
                NSString *rwmrl = [NSString stringWithFormat:@"%@d1/index.html",HTTPAPI];
                shareWeb.webpageUrl = rwmrl;
                message.shareObject = shareWeb;
                
                [[UMSocialManager defaultManager] shareToPlatform:type messageObject:message currentViewController:weakSelf completion:^(id result, NSError *error) {
                    
                }];
            }else{
                //zalo
                NSString *rwmrl = [NSString stringWithFormat:@"%@d1/index.html",HTTPAPI];
                
                ZOFeed * feed = [[ZOFeed alloc ] initWithLink:rwmrl appName:@"VÉ RẺ NAM BẮC THÔNG" message:@"" others:@{}];
                
//                linkTile：titlecủalinkcầnchiaẻ
//                linkDesc：môtảcủa链接
//                linkThumb：chuỗicácurlthumbnailcủalink，cáchnhaubởidấuphẩy
//                linkSource：domainnguồncủa链接
                
                [[ZaloSDK sharedInstance] shareFeed: feed
                                       inController:weakSelf.navigationController
                                           callback:^(ZOShareResponseObject *response)
                 {
                     if (response.success) {
                         [ZDKProgressHUD showSuccessWithStatus:@"Chia sẻ feed link thành công !"];
                     } else {
                         [ZDKProgressHUD showErrorWithStatus:@"Chia sẻ feed link thất bại !"];
                     }
                 }];
               
            }
        }];
    }
    return _shareview;
}

@end
