//
//  ONTMnemonicCodeTools.h
//  eos4O
//
//  Created by Yuzhiyou on 2018/7/19.
//  Copyright © 2018年 MediShares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MnemonicCode.h"

@interface ONTMnemonicCode : MnemonicCode
// 解密
+(NSString *)decryptMnemonicCode:(NSString *)encryptedMnemonicCode password:(NSString *)password address:(NSString *)address;
// 加密
+(NSString *)encryptMnemonicCode:(NSString *)mnemonicCode password:(NSString *)password address:(NSString *)address;

@end
