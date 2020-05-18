//
//  SDTagsView.h
//  SDTagsView
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsModel.h"

#define mDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高

@interface SDTagsView : UIView
@property (nonatomic,strong)NSArray *tagsArr;
+(instancetype)sdTagsViewWithTagsArr:(NSArray*)tagsArr;

@property (nonatomic, copy) void (^selectTagsBloak)(TagsModel *mdoel);

@end
