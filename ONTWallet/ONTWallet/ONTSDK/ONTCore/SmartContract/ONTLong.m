//
//  ONTInteger.m
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/25.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import "ONTLong.h"

@implementation ONTLong
/**
 * @brief Initialization method
 */
- (instancetype)initWithLong:(long)l{
    self = [super init];
    if (self) {
        _value = l;
    }
    return self;
}
@end
