//
//

#import <UIKit/UIKit.h>

@interface UIImage (XBKit)


/**
 *  创建圆角 创建高性能圆角
 *  在tableview/conllectionview的cell比较多的情况下使用
 *  不建议使用layer设置圆角方式
 */
- (UIImage *)cropImageWithRect:(CGRect)cropRect;

#pragma mark 生成image
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

#pragma mark color -> image
/**
 *  颜色转换成图像
 *
 *  @param color 颜色
 *
 *  @return UImage
 */
+ (UIImage *)createImageWithColor:(UIColor*)color;

#pragma mark 生成二维码---条形码
/**
 *  二维码生成(Erica Sadun 原生代码生成)
 *
 *  @param string   内容字符串
 *  @param size 二维码大小
 *  @param color 二维码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;
/**
 *  条形码生成(Third party)
 *
 *  @param code   内容字符串
 *  @param size  条形码大小
 *  @param color 条形码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;

@end
