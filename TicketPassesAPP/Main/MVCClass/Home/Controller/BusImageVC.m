//
//  BusImageVC.m
//  TicketPassesAPP
//
//  Created by caochun on 2019/11/5.
//  Copyright © 2019 macbook. All rights reserved.
//

#import "BusImageVC.h"

#import "StorePhotoCell.h"
#import "ShowImagesController.h"

@interface BusImageVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *photoArr;
    NSMutableArray *photoNameArr;
}
@end

@implementation BusImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setWidth:DEVICE_Width];
    [self.view setHeight:DEVICE_Height-SafeAreaTopHeight-50];
    
    [self getImageData];
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    
}


- (void)getImageData {

    HttpManager *hm = [HttpManager createHttpManager];
    hm.responseHandler = ^(id responseObject) {

        dispatch_async(dispatch_get_main_queue(), ^{

            ResponseData *rd = [ResponseData mj_objectWithKeyValues:responseObject];

            if ([rd.code isEqualToString:SUCCESS] ) {

                NSArray *photoArray = [[rd.data objectForKey:@"images"] copy];

                photoNameArr = [[NSMutableArray alloc] init];
                photoArr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in photoArray) {
                    NSString *urlStr = [dic objectForKey:@"image"];
                    NSString *imageUrlStr = urlStr;
                    [photoNameArr addObject:imageUrlStr];
                    [photoArr addObject:imageUrlStr];
                }

                [self.collectionView reloadData];

            } else {
                [SVProgressHUD showErrorWithStatus:rd.msg];
            }
        });

    };

    NSDictionary *dataDic = @{@"company_id":_company_id};

    [hm getRequetInterfaceData:dataDic withInterfaceName:@"api/ticket/getcompanyimage"];

}


- (void)leftBtnOnTouch:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 0;
        //上下间距
        flowlayout.minimumLineSpacing = 16;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-SafeAreaTopHeight-50) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"StorePhotoCell" bundle:nil] forCellWithReuseIdentifier:@"StorePhotoCell"];
//        //注册分区头标题
//        [_collectionView registerNib:[UINib nibWithNibName:@"HotRecommendHeaderView" bundle:nil]
//          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                 withReuseIdentifier:@"HotRecommendHeaderView"];
        
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return photoNameArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    StorePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorePhotoCell" forIndexPath:indexPath];
    
    NSString *imageUrlStr = [photoNameArr objectAtIndex:indexPath.row];
    NSLog(@"\nimageUrlStr:%@\n",imageUrlStr);
    imageUrlStr = [imageUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    imageUrlStr = [NSString stringWithFormat:@"%@%@",IMAGEPREFIX,imageUrlStr];
    
    
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"bg_default"]];

    
    cell.photoImageView.contentMode = UIViewContentModeScaleToFill;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowImagesController *imageVC = [[ShowImagesController alloc] init];
    imageVC.imageArray = photoArr;
    imageVC.imageNameArray = photoNameArr;
    imageVC.selectedIndex = indexPath.row;
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DEVICE_Width - 16*3)/2.0f, ((DEVICE_Width - 16*3)/2.0f)*(9.0f/16.0f));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(16, 16, 0, 16);
}

@end
