//
//  ONTBalance.h
//  MediSharesiOS
//
//  Created by zhangyutao on 2018/7/11.
//  Copyright © 2018年 zhongtuobang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONTBalance : NSObject

@property (nonatomic, strong) NSString *assetId;  // Token Hash
@property (nonatomic, strong) NSString *name;     // Token 名字
@property (nonatomic, strong) NSString *type;     // 资产类型
@property (nonatomic, strong) NSString *balances; // 资产余额

@end
