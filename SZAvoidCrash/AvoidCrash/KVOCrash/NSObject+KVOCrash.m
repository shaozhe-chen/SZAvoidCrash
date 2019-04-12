//
//  NSObject+KVOCrash.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/11.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "NSObject+KVOCrash.h"
#import <objc/message.h>
#import "NSObject+AvoidCrash.h"

static NSString *kmObserversIdentify = @"kmObserversIdentify";

@interface NSObject ()
@property (atomic, strong) NSHashTable *mObservers;
@end

@implementation NSObject (KVOCrash)
+ (void)load {
    
    classMethodSwizzle(self, @selector(addObserver:forKeyPath:options:context:), @selector(sz_addObserver:forKeyPath:options:context:));
    classMethodSwizzle(self, @selector(removeObserver:forKeyPath:), @selector(sz_removeObserver:forKeyPath:));
}

- (void)sz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    @try {
        //写错keypath的时候，valueForKey会crash，使用try_catch可以避免崩溃
        [self valueForKey:keyPath];
        //如果没有崩溃则继续走
        if (observer && keyPath.length > 0 && keyPath != nil) {
            //避免重复添加
            if (![self hasSameObserversKeyPath:keyPath observer:observer]) {
                @synchronized (self) {
                    NSMapTable *map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
                    [map setObject:observer forKey:keyPath];
                    [self.mObservers addObject:map];
                    NSLog(@"add :%@",self.mObservers.allObjects);
                    [self sz_addObserver:observer forKeyPath:keyPath options:options context:context];
                }
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"没有该keypath：%@",[NSString stringWithFormat:@"%@",keyPath]);
    } @finally {
        
    }
}

- (void)sz_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    if (observer) {
        //移除已经添加过的监听。避免写错keypath导致crash
        NSMapTable *dic = [self hasSameObserversKeyPath:keyPath observer:observer];
        if (dic) {
            @synchronized (self) {
              [self.mObservers removeObject:dic];
            }
            [self sz_removeObserver:observer forKeyPath:keyPath];
        }
    }
}

- (NSMapTable *)hasSameObserversKeyPath:(NSString *)keyPath observer:(id)observer {
    NSMapTable *dic_ = nil;
    NSHashTable *table = self.mObservers;
    NSLog(@"same : %@",table.allObjects);
    for (NSMapTable *dic in [self.mObservers allObjects]) {
        id obj = [dic objectForKey:keyPath];
        id key = [[dic keyEnumerator] allObjects].firstObject;
        if ([key isEqualToString:keyPath] && [observer isEqual:obj]) {
            dic_ = dic;
            break;
        }
    }
    return dic_;
}

#pragma 实现mObservers的声明
- (void)setMObservers:(NSHashTable *)mObservers {
    objc_setAssociatedObject(self, &kmObserversIdentify, mObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSHashTable *)mObservers {
    NSHashTable *mObservers_ = objc_getAssociatedObject(self, &kmObserversIdentify);
    if (!mObservers_) {
        mObservers_ = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsStrongMemory capacity:5];
        objc_setAssociatedObject(self, &kmObserversIdentify, mObservers_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mObservers_;
}
@end
