//
//  HActiveTableView.m
//  HActiveTableView
//
//  Created by 白仕云 on 2018/10/27.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "HActiveTableView.h"



@interface HActiveTableViewCell()

@end

@implementation HActiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {

        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    return self;
}
@end



@interface HActiveTableView()<UITableViewDataSource,UITableViewDelegate>


/**
  数组数据
 */
@property (nonatomic,strong,nonnull)NSMutableArray *copyDataArray;

@end

@implementation HActiveTableView


/**
 重写UITableView的init方法
 @param frame 大小、位置
 @param style UITableViewStyle
 @return UITableView
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style 
{

    self = [super initWithFrame:frame style:UITableViewStylePlain];

    if (self) {

        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc]init];
        [self registerClass:[HActiveTableViewCell class] forCellReuseIdentifier: @"HActiveTableViewCell"];
    }
    return self;
}


/**

 */
-(void)Cell:(UITableViewCell *)cell   IndexPath:(NSIndexPath *)indexPath {

    if (self.getCell_HActiveTableView) {
        self.getCell_HActiveTableView((HActiveTableViewCell *)cell, indexPath);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.copyDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HActiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HActiveTableViewCell"];
    [self Cell:cell IndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    HActiveTableViewCell *cell = (HActiveTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.didSelectRowCell_HActiveTableView) {
        self.didSelectRowCell_HActiveTableView(cell, indexPath);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
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

