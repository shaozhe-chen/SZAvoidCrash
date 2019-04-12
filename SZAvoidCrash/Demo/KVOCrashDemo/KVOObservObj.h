//
//  KVOObservObj.h
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/11.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOObservObj : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, assign) NSInteger age;



- (void)startTimer;
- (void)endTimer;
@end

NS_ASSUME_NONNULL_END
