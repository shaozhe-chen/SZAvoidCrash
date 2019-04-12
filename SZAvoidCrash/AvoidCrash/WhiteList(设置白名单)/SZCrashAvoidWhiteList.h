//
//  SZCrashAvoidWhiteList.h
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/12.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZCrashAvoidWhiteList : NSObject
@property (atomic, strong) NSMutableArray *timerWhiteList;//定时器防crash白名单
@property (atomic, strong) NSMutableArray *kvoWhiteList;//kvo防crash白名单
@property (atomic, strong) NSMutableArray *unSelectorWhiteList;//unSelector防crash白名单

+ (instancetype)shareInstance;
- (void)userInAllCrashWithWhiteLists:(NSArray *)whiteLists;
- (void)userInKVOCrashWithWhiteLists:(NSArray *)whiteLists;
- (void)userInTimerCrashWithWhiteLists:(NSArray *)whiteLists;
- (void)userInunSelectorCrashWithWhiteLists:(NSArray *)whiteLists;

- (BOOL)timerWhiteListContainClass:(Class)cls;
- (BOOL)KVOWhiteListContainClass:(Class)cls;
- (BOOL)unSelectorWhiteListContainClass:(Class)cls;
@end

NS_ASSUME_NONNULL_END
