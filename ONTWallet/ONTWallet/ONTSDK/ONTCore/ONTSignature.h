//
//  ONTSignature.h
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/26.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTSignature : NSObject
@property (nonatomic,readonly) NSMutableArray<NSData *> *publicKeys;
@property (nonatomic,readonly) NSUInteger M;
@property (nonatomic,readonly) NSMutableArray<NSData *> *signatureDatas;

-(instancetype)initWithPublicKey:(NSData *)publicKey signature:(NSData *)signature;
/**
 * @brief Obtaining complete byte stream data
 */
- (void)toByte:(NSMutableData *)stream;
@end
