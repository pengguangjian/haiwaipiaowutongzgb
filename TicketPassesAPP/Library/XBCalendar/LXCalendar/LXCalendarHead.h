//
//  LXCalendarHead.h
//  LXCalendar
//
//  Created by 肖世恒 on 2019/7/28.
//  Copyright © 2019 漫漫. All rights reserved.
//

#ifndef LXCalendarHead_h
#define LXCalendarHead_h

#define LXWeakSelf(weakSelf)  __weak __typeof(self) weakSelf = self;
#define LXNAVH (MAX(LXDevice_Height, LXDevice_Height)  == 812 ? 88 : 64)
#define LXTABBARH 49
#define LXDevice_Width  [[UIScreen mainScreen] bounds].size.width//获取屏幕宽高
#define LXDevice_Height [[UIScreen mainScreen] bounds].size.height
#import "LxButton.h"
#import "UIColor+Expanded.h"
#import "UILabel+LXLabel.h"
#import "UIView+LX_Frame.h"
#import "UIView+FTCornerdious.h"
#import "NSString+NCDate.h"

#endif /* LXCalendarHead_h */
