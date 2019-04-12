//
//  KVOObservObj.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/11.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "KVOObservObj.h"

@interface KVOObservObj ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation KVOObservObj

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static KVOObservObj *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[KVOObservObj alloc] init];
    });
    return obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startTimer {
    [self.timer fire];
}

- (void)endTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark timerCallBack
- (void)timerCallBack {
    self.age += 1;
    NSLog(@"定时器回调：%@",@(self.age));
}

#pragma mark Getter
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerCallBack) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)dealloc {
    NSLog(@"%@  %@",NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}
@end
