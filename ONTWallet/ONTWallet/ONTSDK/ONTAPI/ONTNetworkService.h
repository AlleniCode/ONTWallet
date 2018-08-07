//
//  ONTNetworkService.h
//  ONTWallet
//
//  Created by zhangyutao on 2018/8/4.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ONTNetworkServiceFetchType) {
    ONTNetworkServiceFetchTypeGET,
    ONTNetworkServiceFetchTypePOST
};

@interface ONTNetworkService : NSObject

+ (instancetype)shareInstance;

- (void)fetchJSONWithType:(ONTNetworkServiceFetchType)type URLString:(NSString *)URLString headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters result:(void (^)(id data, NSError *error))result;

@end
