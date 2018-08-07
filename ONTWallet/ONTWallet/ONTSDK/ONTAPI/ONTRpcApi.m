//
//  ONTRpcApi.m
//  ONTWallet
//
//  Created by zhangyutao on 2018/8/4.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#import "ONTRpcApi.h"
#import <AFJSONRPCClient/AFJSONRPCClient.h>
#import "ONTBalance.h"
#import "ONTUtils.h"
#import "ONT.h"

@interface ONTRpcApi()

@property (nonatomic, strong) AFJSONRPCClient *client;

@end

@implementation ONTRpcApi

static ONTRpcApi *_instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        [_instance initData];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ONTRpcApi shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ONTRpcApi shareInstance];
}

- (void)initData {
    _client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:kONTRpcURL]];
}

- (void)setRpcURL:(NSString *)rpcURL {
    _rpcURL = rpcURL;
    
    if (_rpcURL && _rpcURL.length > 0) {
        _client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:_rpcURL]];
    }
}

- (void)getBestBlockHashCallback:(void (^)(NSString *, NSError *))callback {
    [self.client invokeMethod:@"getbestblockhash" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getbestblockhash】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getbestblockhash】%@", error);
        callback(nil, error);
    }];
}

- (void)getBlockWithTxHash:(NSString *)txHash verbose:(BOOL)verbose callback:(void (^)(id, NSError *))callback {
    [self.client invokeMethod:@"getblock" withParameters:@[txHash, verbose?@(1):@(0)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblock】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblock】%@", error);
        callback(nil, error);
    }];
}

- (void)getBlockWithHeight:(long)height verbose:(BOOL)verbose callback:(void (^)(id, NSError *))callback {
    [self.client invokeMethod:@"getblock" withParameters:@[@(height), verbose?@(1):@(0)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblock】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblock】%@", error);
        callback(nil, error);
    }];
}

- (void)getBlockCountCallback:(void (^)(NSInteger blockCount, NSError *error))callback {
    [self.client invokeMethod:@"getblockcount" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblockcount】%@", responseObject);
        NSString *blockCount = [NSString stringWithFormat:@"%@", responseObject];
        callback(blockCount.integerValue, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblockcount】%@", error);
        callback(0, error);
    }];
}

+ (void)getBlockCountWithUrl:(NSString *)urlString callback:(void (^)(NSInteger blockCount, NSError *error))callback {
    if (urlString && urlString.length > 0) {
        AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
        [client invokeMethod:@"getblockcount" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"【ONTRpcApi getblockcount】%@", responseObject);
            NSString *blockCount = [NSString stringWithFormat:@"%@", responseObject];
            callback(blockCount.integerValue, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"【ONTRpcApi getblockcount】%@", error);
            callback(0, error);
        }];
    } else {
        callback(0, nil);
    }
}

- (void)getBlockHashWithHeight:(long)height callback:(void (^)(NSString *txHash, NSError *error))callback {
    [self.client invokeMethod:@"getblockhash" withParameters:@[@(height)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblockhash】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblockhash】%@", error);
        callback(nil, error);
    }];
}

- (void)getConnectionCountCallback:(void (^)(NSInteger connectionCount, NSError *error))callback {
    [self.client invokeMethod:@"getconnectioncount" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getconnectioncount】%@", responseObject);
        NSString *connectionCount = [NSString stringWithFormat:@"%@", responseObject];
        callback(connectionCount.integerValue, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getconnectioncount】%@", error);
        callback(0, error);
    }];
}

+ (void)getConnectionCountWithUrl:(NSString *)urlString callback:(void (^)(NSInteger connectionCount, NSError *error))callback {
    if (urlString && urlString.length > 0) {
        AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
        [client invokeMethod:@"getconnectioncount" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"【ONTRpcApi getconnectioncount】%@", responseObject);
            NSString *connectionCount = [NSString stringWithFormat:@"%@", responseObject];
            callback(connectionCount.integerValue, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"【ONTRpcApi getconnectioncount】%@", error);
            callback(0, error);
        }];
    } else {
        callback(0, nil);
    }
}

- (void)getRawtransactionWithTxHash:(NSString *)txHash verbose:(BOOL)verbose callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getrawtransaction" withParameters:@[txHash, verbose?@(1):@(0)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getrawtransaction】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getrawtransaction】%@", error);
        callback(nil, error);
    }];
}

- (void)sendRawtransactionWithHexTx:(NSString *)hexTx preExec:(BOOL)preExec callback:(void (^)(NSString *txHash, NSError *error))callback {
    [self.client invokeMethod:@"sendrawtransaction" withParameters:@[hexTx, preExec?@(1):@(0)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi sendrawtransaction】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi sendrawtransaction】%@", error);
        callback(nil, error);
    }];
}

- (void)getStorageWithScriptHash:(NSString *)scriptHash key:(NSString *)key callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getstorage" withParameters:@[scriptHash, key] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getstorage】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getstorage】%@", error);
        callback(nil, error);
    }];
}

- (void)getVersionCallback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getversion" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getversion】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getversion】%@", error);
        callback(nil, error);
    }];
}

- (void)getContractStateWithScriptHash:(NSString *)scriptHash verbose:(BOOL)verbose callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getcontractstate" withParameters:@[scriptHash, verbose?@(1):@(0)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getcontractstate】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getcontractstate】%@", error);
        callback(nil, error);
    }];
}

- (void)getMempoolTxCountCallback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getmempooltxcount" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getmempooltxcount】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getmempooltxcount】%@", error);
        callback(nil, error);
    }];
}

- (void)getMempoolTxStateWithTxHash:(NSString *)txHash callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getmempooltxstate" withParameters:@[txHash] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getmempooltxstate】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getmempooltxstate】%@", error);
        callback(nil, error);
    }];
}

- (void)getSmartCodeEventWithTxHash:(NSString *)txHash callback:(void (^)(NSInteger state, NSError *error))callback {
    [self.client invokeMethod:@"getsmartcodeevent" withParameters:@[txHash] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getsmartcodeevent】%@", responseObject);
        NSString *state = [responseObject valueForKey:@"State"];
        callback(state.integerValue, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getsmartcodeevent】%@", error);
        callback(-1, error);
    }];
}

- (void)getSmartCodeEventWithBlockHeight:(long)height callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getsmartcodeevent" withParameters:@[@(height)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getsmartcodeevent】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getsmartcodeevent】%@", error);
        callback(nil, error);
    }];
}

- (void)getBlockHeightWithTxhash:(NSString *)txHash callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getblockheightbytxhash" withParameters:@[txHash] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblockheightbytxhash】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblockheightbytxhash】%@", error);
        callback(nil, error);
    }];
}

- (void)getBalanceWithAddress:(NSString *)address callback:(void (^)(NSArray *balances, NSError *error))callback {
    [self.client invokeMethod:@"getbalance" withParameters:@[address] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getbalance】%@", responseObject);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        ONTBalance *ontBalance = [ONTBalance new];
        ontBalance.name = @"ONT";
        ontBalance.balances = responseObject[@"ont"];
        [array addObject:ontBalance];
        
        ONTBalance *ongBalance = [ONTBalance new];
        ongBalance.name = @"ONG";
        ongBalance.balances = [ONTUtils decimalNumber:responseObject[@"ong"] byDividingBy:@"1000000000.0"];
        [array addObject:ongBalance];
        
        callback(array, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getbalance】%@", error);
        callback(nil, error);
    }];
}

- (void)getMerkleProofWithTxHash:(NSString *)txHash callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getmerkleproof" withParameters:@[txHash] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getmerkleproof】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getmerkleproof】%@", error);
        callback(nil, error);
    }];
}

- (void)getGaspriceCallback:(void (^)(NSString *gasprice, NSError *error))callback {
    [self.client invokeMethod:@"getgasprice" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getgasprice】%@", responseObject);
        NSString *gasprice = [responseObject valueForKey:@"gasprice"];
        callback(gasprice, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getgasprice】%@", error);
        callback(nil, error);
    }];
}

- (void)getAllowanceWithAsset:(NSString *)asset fromAddress:(NSString *)fromAddress toAddress:(NSString *)toAddress callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getallowance" withParameters:@[asset, fromAddress, toAddress] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getallowance】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getallowance】%@", error);
        callback(nil, error);
    }];
}

- (void)getUnboundOng:(NSString *)address callback:(void (^)(NSString *, NSError *))callback {
    [self.client invokeMethod:@"getunboundong" withParameters:@[address] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getunboundong】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getunboundong】%@", error);
        callback(nil, error);
    }];
}

- (void)getBlockTxsWithHeight:(long)height callback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getblocktxsbyheight" withParameters:@[@(height)] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getblocktxsbyheight】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getblocktxsbyheight】%@", error);
        callback(nil, error);
    }];
}

- (void)getNetworkIDCallback:(void (^)(id result, NSError *error))callback {
    [self.client invokeMethod:@"getnetworkid" withParameters:@[] requestId:@(3) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"【ONTRpcApi getnetworkid】%@", responseObject);
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"【ONTRpcApi getnetworkid】%@", error);
        callback(nil, error);
    }];
}

@end
