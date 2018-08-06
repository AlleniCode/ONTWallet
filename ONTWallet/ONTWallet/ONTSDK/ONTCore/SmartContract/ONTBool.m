//
//  ONTBool.m
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/25.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import "ONTBool.h"

@implementation ONTBool
/**
 * @brief Initialization method
 */
- (instancetype)initWithBool:(BOOL)b{
    self = [super init];
    if (self) {
        _value = b;
    }
    return self;
}
@end
