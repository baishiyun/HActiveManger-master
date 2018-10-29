//
//  HActiveTableView.h
//  HActiveTableView
//
//  Created by 白仕云 on 2018/10/27.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface HActiveTableViewCell : UITableViewCell

@end





@interface HActiveTableView : UITableView


/**
 传入的数据源，
 */
@property (nonatomic ,strong,nonnull)NSArray *dataArray;


/**
 通过获取到对应的cell，去添加自己的view，并且获取到对应的 NSIndexPath
 */
@property (nonatomic ,copy,nonnull)void(^getCell_HActiveTableView)(HActiveTableViewCell *cell,NSIndexPath * cellIndexPath);


/**
 点击对应的cell，并且获取到对应的 NSIndexPath
 */
@property (nonatomic ,copy,nonnull)void(^didSelectRowCell_HActiveTableView)(HActiveTableViewCell *cell,NSIndexPath * cellIndexPath);
@end



NS_ASSUME_NONNULL_END
