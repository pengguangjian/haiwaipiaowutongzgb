//
//  XSpotLight.h
//  FitnewAPP
//
//  Created by Yudong on 2017/3/1.
//  Copyright © 2017年 xida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XManager.h"

@class XSpotLight;

@protocol XSpotLightDelegate <NSObject>

@optional
- (void)XSpotLightClicked:(NSInteger)index;

@end

@interface XSpotLight : UIViewController<XSpotDelegate>
{
    XManager *modalState;
}

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic,       ) NSArray *rectArray;
@property (nonatomic, weak  ) id<XSpotLightDelegate> delegate;

@end
