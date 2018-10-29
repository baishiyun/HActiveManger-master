//
//  HActiveCollectionView.m
//  HActiveTableView
//
//  Created by 白仕云 on 2018/10/27.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "HActiveCollectionView.h"

@interface HActiveCollectionViewCell()

@end
@implementation HActiveCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }

    return self;
}

@end


@interface HActiveCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

/**
 数组数据
 */
@property (nonatomic,strong,nonnull)NSMutableArray *copyDataArray;

@end

@implementation HActiveCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{

    self = [super initWithFrame:frame collectionViewLayout:layout];

    if (self) {


        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[HActiveCollectionViewCell class] forCellWithReuseIdentifier:@"HActiveCollectionViewCell"];
    }

    return self;
}

/**

 */
-(void)Cell:(HActiveCollectionViewCell *)cell   IndexPath:(NSIndexPath *)indexPath {

    if (self.getCell_HActiveTableView) {
        self.getCell_HActiveTableView(cell, indexPath);
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.copyDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HActiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HActiveCollectionViewCell" forIndexPath:indexPath];
    [self Cell:cell IndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HActiveCollectionViewCell *cell = (HActiveCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.didSelectRowCell_HActiveTableView) {
        self.didSelectRowCell_HActiveTableView(cell, indexPath);
    }
}
-(void)setDataArray:(NSMutableArray * _Nonnull)dataArray
{
    _dataArray  =dataArray;

    [self.copyDataArray  removeAllObjects];
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    [self.copyDataArray addObjectsFromArray:dataArray];

    if([[NSThread currentThread] isMainThread]==true){
        [self reloadData];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }

}

-(NSMutableArray *)copyDataArray
{
    if (!_copyDataArray) {
        _copyDataArray = [NSMutableArray array];
    }
    return _copyDataArray;
}
@end
