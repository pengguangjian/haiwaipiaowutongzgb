//
//  TagsModel.h
//  SDTagsView
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface TagsModel : BaseModel

/**
 标签标题
 */
@property (nonatomic,strong) CityModel *startModel;

@property (nonatomic,strong) CityModel *endModel;

@property (nonatomic,strong) NSString *searchID;


@end
