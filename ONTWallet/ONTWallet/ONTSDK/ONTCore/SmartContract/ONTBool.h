//
//  ONTBool.h
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/25.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTBool : NSObject
@property (nonatomic,assign) BOOL value;
/**
 * @brief Initialization method
 */
- (instancetype)initWithBool:(BOOL)b;
@end
