//
//  HActiveManger.m
//  HActiveManger
//
//  Created by 白仕云 on 2018/10/25.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "HActiveManger.h"

@implementation HActiveManger


/**
 初始化存储对象 NSUserDefaults

 @return 返回
 */
+(NSUserDefaults *)currentDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return defaults;
}

/**
 存储
 @param parameter 存储的数据（基本数据类型也可以，但是自定义的类型不支持）
 @param key key值
 @param Complete 存储完成状态（True，Flase）
 */
+(void)saveParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{

     BOOL query = false;
    [self Parameter:parameter Key:key Complete:Complete];
    NSMutableArray *saveArray = [NSMutableArray array];

    if ([parameter isKindOfClass:[NSArray class]]) {

        for (id obj in parameter) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [saveArray addObject:[self fileterParameter:obj]];
                query = true;
            }else{
                NSLog(@"这是 %@ 类型，必须是字典存储",NSStringFromClass([obj class]));
                query = false;
            }
        }
    }else if([parameter isKindOfClass:[NSDictionary class]]){
        [saveArray addObject:[self fileterParameter:parameter]];
            query = true;
    }else{
        NSLog(@"这是 %@ 类型，必须是字典存储",NSStringFromClass([parameter class]));
            query = false;
    }
    [[self currentDefaults] setObject:saveArray forKey:key];

    if (query ==true) {

        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }else{
            Complete(query,[NSMutableArray array]);

        }
    }

}


/**
 新增数据存储
 @param parameter 存储的数据
 @param key key值
 @param Complete 存储完成状态（True，Flase）
 */
+(void)addSaveParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{

     BOOL query = false;
    [self Parameter:parameter Key:key Complete:Complete];
    if (![[self currentDefaults] objectForKey:key]) {
        [self saveParameter:parameter Key:key Complete:Complete];
          query = true;
    }else{

        NSArray *saveData = [[self currentDefaults] objectForKey:key];
        NSMutableArray *saveDataArray = [saveData mutableCopy];
        if ([parameter isKindOfClass:[NSArray class]]) {

            for (id obj in parameter) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [saveDataArray insertObject:[self fileterParameter:obj] atIndex:0];
                        query = true;
                }else{
                    NSLog(@"这是 %@ 类型，必须是字典存储",NSStringFromClass([obj class]));
                    query = false;
                }
            }
        }else if ([parameter isKindOfClass:[NSDictionary class]]){
            [saveDataArray insertObject:[self fileterParameter:parameter] atIndex:0];
            query = true;
        }

        [[self currentDefaults] setObject:saveDataArray forKey:key];
    }

        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }
}

/**
 更新存储
 @param majorValue 更新的值 ，对应主键majorkey的Value
 @param key key值
 @param majorkey majorkey值(这是需要更新对象的主键)
 @param Complete 存储完成状态（True，Flase）
 */
+(void)updateMajorValue:(id)majorValue Key:(NSString *)key majorkey:(NSString *)majorkey  Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete;
{

    BOOL query = false;
    [self Parameter:@"" Key:key Complete:Complete];

    if (!majorkey) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        NSLog(@"majorkey不存在");

        return;
    }

    if (!majorValue) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
            NSLog(@"majorValue不存在");
        return;
    }

    if (![[self currentDefaults] objectForKey:key]) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        return;
    }else{

            NSArray *saveData = [[self currentDefaults] objectForKey:key];
            NSMutableArray *saveDataArray = [saveData mutableCopy];
            for (int index=0; index<saveDataArray.count; index++) {

                id indexObj = [saveDataArray objectAtIndex:index];
                //判断存储数组中的对象是什么类型,因为根据主键去查找，因此只能是字典
                 if ([indexObj isKindOfClass:[NSDictionary class]]){


                     NSArray *IndexObjKey  =[indexObj allKeys];

                     if ([IndexObjKey containsObject:majorkey]) {
                         NSMutableDictionary *updateIndexObj = [indexObj mutableCopy];
                         [updateIndexObj setObject:majorValue forKey:majorkey];
                             query = true;
                         [saveDataArray replaceObjectAtIndex:index withObject:updateIndexObj];

                     }else{
                             query = false;
                         [saveDataArray replaceObjectAtIndex:index withObject:indexObj];
                     }

                 }else{
                     [saveDataArray replaceObjectAtIndex:index withObject:indexObj];
                 }
            }

            [[self currentDefaults] setObject:saveDataArray forKey:key];
        }


        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }
}



/**
 删除其中一条存储
 @param parameter 需要删除据
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedOnlyOneParameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{
    BOOL query = false;
    [self Parameter:@"" Key:key Complete:Complete];

    if (![[self currentDefaults] objectForKey:key]) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        return;
    }else{

        NSArray *saveData = [[self currentDefaults] objectForKey:key];
        NSMutableArray *saveDataArray = [saveData mutableCopy];
        if ([saveDataArray containsObject:parameter]) {
            [saveDataArray removeObject:parameter];
            [[self currentDefaults] setObject:saveDataArray forKey:key];
               query = true;
        }else{
               query = false;
        }
    }

        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }

}


/**
 根据存储的字段中的一个key值去删除
 @param majorkey 删除的主键（删除的依据）
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedMajorkey:(NSString *)majorkey Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{
    BOOL query = false;
    [self Parameter:@"" Key:key Complete:Complete];


    if (!majorkey) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        NSLog(@"majorkey不存在");

        return;
    }


    if (![[self currentDefaults] objectForKey:key]) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        return;
    }else{
        NSArray *saveData = [[self currentDefaults] objectForKey:key];
        NSMutableArray *saveDataArray = [saveData mutableCopy];

        NSMutableArray *resultArray  =[NSMutableArray arrayWithCapacity:saveDataArray.count];

        for (int index=0; index<saveDataArray.count; index++) {

            id indexObj = [saveDataArray objectAtIndex:index];

            if ([indexObj isKindOfClass:[NSDictionary class]]) {

                NSArray *indexObjKey = [indexObj allKeys];
                //有主键majorkey删除，不保留
                if (![indexObjKey containsObject:majorkey]) {
                    [resultArray addObject:indexObj];
                     query = true;
                }
            }
        }

        if (resultArray.count==saveDataArray.count) {
            query = false;
            NSLog(@"存储的字典数据中没有找到带有majorkey为key的d对象");
        }
        [[self currentDefaults] setObject:resultArray forKey:key];
    }

        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }

}



/**
 根据存储的字段中的每一个key和majorValue 值去删除
 @param majorkey 删除的主键（删除的依据）
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedMajorkey:(NSString *)majorkey  MajorValue:(id)majorValue Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{
    BOOL query = false;
    [self Parameter:@"" Key:key Complete:Complete];


    if (!majorkey) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        NSLog(@"majorkey不存在");

        return;
    }

    if (!majorValue) {
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        NSLog(@"majorValue不存在");
        return;
    }

    if (![[self currentDefaults] objectForKey:key]) {

        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        return;

    }else{
        NSArray *saveData = [[self currentDefaults] objectForKey:key];
        NSMutableArray *saveDataArray = [saveData mutableCopy];

        NSMutableArray *resultArray  =[NSMutableArray arrayWithCapacity:saveDataArray.count];

        for (int index=0; index<saveDataArray.count; index++) {

            id indexObj = [saveDataArray objectAtIndex:index];

            if ([indexObj isKindOfClass:[NSDictionary class]]) {

                NSArray *indexObjKey = [indexObj allKeys];

                //这里有两种情况，第一种就是不存在majorkey，如果不存在majorkey，那么保留下来
                if (![indexObjKey containsObject:majorkey]) {
                    [resultArray addObject:indexObj];
                    query = true;

                    //这里有两种情况，第二种就是存在majorkey，如果存在majorkey，那么我们需要进一步判断majorValue

                }else if ([indexObjKey containsObject:majorkey]){

                    //如果 [[indexObj objectForKey:majorkey] isEqualToString:majorValue]是false，那么证明没有找到要删除的数据
                    NSString *value = [NSString stringWithFormat:@"%@",[indexObj objectForKey:majorkey]];

                    if (![value isEqualToString:majorValue]) {
                        [resultArray addObject:indexObj];
                        query = true;
                    }

                }
            }
        }

        if (resultArray.count==saveDataArray.count) {
            query = false;
            NSLog(@"存储的字典数据中没有找到带有majorkey为key的d对象");
        }
        [[self currentDefaults] setObject:resultArray forKey:key];
    }

        if (Complete) {
            Complete(query,[[self currentDefaults] objectForKey:key]);
        }
}


/**
 全部删除
 @param key key值
 @param Complete 删除完成状态（True，Flase）
 */
+(void)deletedAllKey:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{
    [self Parameter:@"" Key:key Complete:Complete];

    [[self currentDefaults] removeObjectForKey:key];

    if (Complete) {
        Complete(true,[[self currentDefaults] objectForKey:key]);
    }
}
/**
 对传入的值进行判断，当参数和keyd只要有其中一个不存在，都直接返回
 @param parameter 需要存储的数据
 @param key key
 @param Complete 结果
 */
+(void)Parameter:(id)parameter Key:(NSString *)key Complete:(void(^)(BOOL complete,NSMutableArray *CompleteArray))Complete
{
    //当存储的数据或者是key不存在直接返回，防止崩溃
    if (!parameter||(!key)) {
        if (!parameter) {
            NSLog(@"parameter 不存在");
        }else if (!key){
            NSLog(@"Key 不存在");
        }else{
            NSLog(@"parameter和dKey都不不存在");
        }
        if (Complete) {
            Complete(false,[NSMutableArray array]);
        }
        return;
    }
}


/**
 为了安全起见。对传入的字段需要做一次安全处理，防止传入的数据中有垃圾数据导致崩溃

 @param parameter 字典
 @return 返回安全数据字典
 */
+(NSMutableDictionary *)fileterParameter:(NSMutableDictionary *)parameter
{
    NSArray *allKey = [parameter allKeys];
    for (int index=0; index<allKey.count; index++) {

        if ([[parameter objectForKey:allKey[index]] isKindOfClass:[NSNull class]]) {

            [parameter setObject:@"" forKey:allKey[index]];

        }else if ([parameter objectForKey:allKey[index]] ==nil){

            [parameter setObject:@"" forKey:allKey[index]];

        }else if ([[parameter objectForKey:allKey[index]] isKindOfClass:[NSNumber class]]){

            NSString *value = [NSString stringWithFormat:@"%@",[parameter objectForKey:allKey[index]]];
            [parameter setObject:value forKey:allKey[index]];
        }else{
            NSString *value = [NSString stringWithFormat:@"%@",[parameter objectForKey:allKey[index]]];
            [parameter setObject:value forKey:allKey[index]];
        }
    }

    return parameter;
}
@end
