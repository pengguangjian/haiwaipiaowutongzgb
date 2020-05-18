//
//  WorkTimeObj.h
//  TechnicianAPP
//
//  Created by Mac on 2018/8/22.
//  Copyright © 2018年 XiaoShunZi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatObj : NSObject
@property (nonatomic, strong) NSNumber *id;//
@property (nonatomic, copy) NSString *seat_code;//
//@property (nonatomic, copy) NSString *row_num;//
@property (nonatomic, strong) NSNumber *row_num;//
@property (nonatomic, strong) NSNumber *col_num;//
@property (nonatomic, strong) NSNumber *price;//
@property (nonatomic, strong) NSNumber *is_available;//
@property (nonatomic, strong) NSNumber *coach_num;//
@property (nonatomic, strong) NSNumber *status;//

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
