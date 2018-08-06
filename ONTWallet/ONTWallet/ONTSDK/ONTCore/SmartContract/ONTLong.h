//
//  ONTLong.h
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/25.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTLong : NSObject
@property (nonatomic,assign) long value;
/**
 * @brief Initialization method
 */
- (instancetype)initWithLong:(long)l;
@end
