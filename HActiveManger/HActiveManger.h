//
//  HActiveManger.h
//  HActiveManger
//
//  Created by 白仕云 on 2018/10/25.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HActiveManger : NSObject

/**
 存储
 @param parameter 存储的数据
 @param key key值
 @param Complete 存储完成状态（True，Flase）
 */
+(void)saveParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete ,NSMutableArray *CompleteArray))Complete;


/**
 新增数据存储
 @param parameter 存储的数据
 @param key key值
 @param Complete 存储完成状态（True，Flase）
 */
+(void)addSaveParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;

/**
 更新存储
 @param majorValue 更新的值 ，对应主键majorkey的Value
 @param key key值
 @param majorkey majorkey值(这是需要更新对象的主键)
 @param Complete 存储完成状态（True，Flase）
 */
+(void)updateMajorValue:(id)majorValue Key:(NSString *)key majorkey:(NSString *)majorkey  Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;


/**
 删除其中每一条存储（这是针对存储的字典中的数据都是一样的的时候可以使用，如果出现存储的字典中key相同，值不相同的不能使用这个方法，需要使用下一个方法）
 @param parameter 存储的数据
  @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedOnlyOneParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;


/**
 根据存储的字段中的每一个key值去删除
 @param majorkey 删除的主键（删除的依据）
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedMajorkey:(NSString *)majorkey Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;



/**
 根据存储的字段中的每一个key和majorValue 值去删除
 @param majorkey 删除的主键（删除的依据）
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedMajorkey:(NSString *)majorkey  MajorValue:(id)majorValue Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;


/**
 全部删除
  @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedAllKey:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;
@end

NS_ASSUME_NONNULL_END
