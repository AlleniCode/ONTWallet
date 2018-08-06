//
//  ONTRestfulApi.m
//  ONTWallet
//
//  Created by zhangyutao on 2018/8/4.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#import "ONTRestfulApi.h"
#import "ONT.h"
#import "ONTNetworkService.h"
#import "ONTBalance.h"

#define ONT_TXN_PAGE_COUNT 10  // 每页的交易数量

@implementation ONTRestfulApi

static ONTRestfulApi* _instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ONTRestfulApi shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ONTRestfulApi shareInstance];
}

- (NSString *)getURLWithVersion:(NSString *)version path:(NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", kONTExplorerBaseURL(version), path];
}

- (void)fectchBalanceWithAddress:(NSString *)address callback:(void (^)(NSArray *balanceList, NSError *error))callback {
    NSString *url = [NSString stringWithFormat:@"%@/%@/%d/%d", [self getURLWithVersion:@"1" path:@"address"], address, 0, 0];
    [[ONTNetworkService shareInstance] fetchJSONWithType:ONTNetworkServiceFetchTypeGET URLString:url headers:nil parameters:nil result:^(id data, NSError *error) {
        if (!error) {
            if (![data isKindOfClass:[NSDictionary class]] || [[data valueForKey:@"Error"] integerValue] != 0) {
                return;
            }
            
            NSDictionary *resultData = [data valueForKey:@"Result"];
            NSArray *array = resultData[@"AssetBalance"];
            if (array && array.count > 0) {
                NSMutableArray *balanceList = [NSMutableArray new];
                for (NSDictionary *dic in array) {
                    ONTBalance *ontBalance = [ONTBalance new];
                    ontBalance.balances = dic[@"Balance"];
                    ontBalance.name = [dic[@"AssetName"] uppercaseString];
                    [balanceList addObject:ontBalance];
                }
                callback(balanceList, nil);
            } else {
            }
        } else {
            callback(nil, error);
        }
    }];
}

- (void)getTransactionHistory:(NSString *)address page:(NSInteger)page callback:(void (^)(NSError *error))callback {
    NSString *url = [NSString stringWithFormat:@"%@/%@/%d/%ld", [self getURLWithVersion:@"1" path:@"address"], address, ONT_TXN_PAGE_COUNT, page];
    [[ONTNetworkService shareInstance] fetchJSONWithType:ONTNetworkServiceFetchTypeGET URLString:url headers:nil parameters:nil result:^(id data, NSError *error) {
        if (!error) {
            if (![data isKindOfClass:[NSDictionary class]] || [[data valueForKey:@"Error"] integerValue] != 0) {
                return;
            }
            
            NSDictionary *resultData = [data valueForKey:@"Result"];
            NSArray *array = resultData[@"TxnList"];
            if (![array isEqual:[NSNull null]] && array.count > 0) {
                for (NSDictionary *dic in array) {
                }
            }
            callback(nil);
        } else {
            callback(error);
        }
    }];
}



@end
