//
//  SZCrashAvoidWhiteList.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/12.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "SZCrashAvoidWhiteList.h"

@interface SZCrashAvoidWhiteList ()
@end

@implementation SZCrashAvoidWhiteList
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static SZCrashAvoidWhiteList *whiteList = nil;
    dispatch_once(&onceToken, ^{
        whiteList = [[SZCrashAvoidWhiteList alloc] init];
    });
    return whiteList;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timerWhiteList = @[].mutableCopy;
        _kvoWhiteList = @[].mutableCopy;
        _unSelectorWhiteList = @[].mutableCopy;
    }
    return self;
}

- (void)userInAllCrashWithWhiteLists:(NSArray *)whiteLists {
    [self userInKVOCrashWithWhiteLists:whiteLists];
    [self userInTimerCrashWithWhiteLists:whiteLists];
    [self userInunSelectorCrashWithWhiteLists:whiteLists];
}

- (void)userInKVOCrashWithWhiteLists:(NSArray *)whiteLists {
    [_kvoWhiteList addObjectsFromArray:whiteLists];
}

- (void)userInTimerCrashWithWhiteLists:(NSArray *)whiteLists {
    [_timerWhiteList addObjectsFromArray:whiteLists];
}

- (void)userInunSelectorCrashWithWhiteLists:(NSArray *)whiteLists {
    [_unSelectorWhiteList addObjectsFromArray:whiteLists];
}

- (BOOL)timerWhiteListContainClass:(Class)cls {
    NSString *clsString = NSStringFromClass(cls);
    for (NSString *clsStr in _timerWhiteList) {
        if ([clsStr isEqualToString:clsString]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)KVOWhiteListContainClass:(Class)cls {
    NSString *clsString = NSStringFromClass(cls);
    for (NSString *clsStr in _kvoWhiteList) {
        if ([clsStr isEqualToString:clsString]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)unSelectorWhiteListContainClass:(Class)cls {
    NSString *clsString = NSStringFromClass(cls);
    for (NSString *clsStr in _unSelectorWhiteList) {
        if ([clsStr isEqualToString:clsString]) {
            return YES;
        }
    }
    return NO;
}
@end
