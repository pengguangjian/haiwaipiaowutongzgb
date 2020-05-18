//
//  CityModel.m
//  TicketPassesAPP
//
//  Created by 肖世恒 on 2019/7/21.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (NSString *)cityname{
    NSInteger type =  [NSBundle getLanguageType];
    if(type == 1){
        return _cityname_y;
    }else if(type == 2){
        return _cityname_e;
    }else{
        return _cityname_c;
    }
    
}

@end
