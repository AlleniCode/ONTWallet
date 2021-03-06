//
//  ECKey.m
//  ectest
//
//  Created by XiaoQing Pan on 2018/3/20.
//  Copyright © 2018 XiaoQing Pan. All rights reserved.
//

#import "ECKey.h"
#import "Categories.h"

@implementation ECKey

- (instancetype)initWithPriKey:(NSData*)priKey {
    return [self initWithKey:priKey Pub:nil];
}

- (instancetype)initWithPubKey:(NSData*)pubKey {
    return [self initWithKey:nil Pub:pubKey];
}
- (instancetype)initWithKey:(NSData*)priKey Pub:(NSData*)pubKey{
    self = [super init];
    if (self) {
        privateKey = priKey;
        publicKey = pubKey;
    }
    return self;
}

- (NSData*)privateKeyAsData {
    return privateKey;
}

- (NSData*)publicKeyAsData {
    return publicKey;
}

- (NSString*)privateKeyAsHex {
    return privateKey.hexString;
}

- (NSString*)publicKeyAsHex {
    return publicKey.hexString;
}

- (NSString*)signAsHex:(NSData*)mess {
    return [self sign:mess].toHex;
}
/**
 * @return signature object
 */
- (ECKeySignature*)sign:(NSData*)mess{
    return nil;
}

/**
 * @brief verification of signature legality
 */
- (Boolean)verify:(NSData*)mess :(ECKeySignature*)sig{
    return false;
}
- (NSString*)description {
    return [NSString stringWithFormat:@"\nprivateKey:%@ \npublicKey:%@",
                privateKey.hexString, publicKey.hexString];
}

@end
