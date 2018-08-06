//
//  ONTInteger.h
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/25.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTInteger : NSObject
@property (nonatomic,assign) NSInteger value;
/**
 * @brief Initialization method
 */
- (instancetype)initWithInteger:(NSInteger)i;
@end
