//
//  NSTimerProxy.h
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/12.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimerProxy : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, weak) NSTimer *timer;
@end

NS_ASSUME_NONNULL_END
