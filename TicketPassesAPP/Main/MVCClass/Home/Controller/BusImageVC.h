//
//  BusImageVC.h
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusImageVC : BaseVC
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *company_id;
@end

NS_ASSUME_NONNULL_END
