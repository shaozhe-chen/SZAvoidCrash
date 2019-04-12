//
//  NSObject+AvoidCrash.h
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/2.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AvoidCrash)
BOOL classMethodSwizzle(Class aClass, SEL originalSelector, SEL swizzleSelector) ;
@end

NS_ASSUME_NONNULL_END
