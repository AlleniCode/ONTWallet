//
//  ONTNetworkService.m
//  ONTWallet
//
//  Created by zhangyutao on 2018/8/4.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#import "ONTNetworkService.h"
#import <AFNetworking/AFNetworking.h>

@implementation ONTNetworkService

static ONTNetworkService* _instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ONTNetworkService shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ONTNetworkService shareInstance];
}

- (void)fetchJSONWithType:(ONTNetworkServiceFetchType)type URLString:(NSString *)URLString headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters result:(void (^)(id data,NSError *error))result {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Headers
    for (NSString *key in [headers allKeys]) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    // Failure
    void (^handleFailure)(NSURLSessionDataTask*, NSError*) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"error=%@",error.description);
        result(nil, error);
    };
    // Success
    void (^handleSuccess)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        result(responseDict, nil);
    };
    // Method
    if (type == ONTNetworkServiceFetchTypePOST) {
        [manager POST:URLString parameters:parameters success:handleSuccess failure:handleFailure];
    } else {
        [manager GET:URLString parameters:parameters success:handleSuccess failure:handleFailure];
    }
}

@end
