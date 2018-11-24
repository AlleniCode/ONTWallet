//
//  ONTMnemonicCode.m
//  ONTWallet
//
//  Created by Yuzhiyou on 2018/7/19.
//  Copyright © 2018年 Yuzhiyou. All rights reserved.
//

#import "ONTMnemonicCode.h"
#import "Categories.h"
#import "crypto_scrypt.h"
#import "MnemonicCode.h"
#import "ONTDeterministicKey.h"
#import "ONTECKey.h"
#import "ONTPublicKey.h"
#import "ONTPrivateKey.h"

@implementation ONTMnemonicCode
// 解密
+(NSString *)decryptMnemonicCode:(NSString *)encryptedMnemonicCode password:(NSString *)password address:(NSString *)address{
    int N = 4096;
    int r = 8;
    int p = 8;
    int dkLen = 64;
    char stop = 0;
    
    NSData *passwordData = [[password precomposedStringWithCompatibilityMapping] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *adressHashTmp = [address dataUsingEncoding:NSUTF8StringEncoding].SHA256_2;
    NSData *salt = [adressHashTmp subdataWithRange:NSMakeRange(0, 4)];
    
    NSMutableData *derivedkey = [NSMutableData dataWithLength:dkLen];
    int status = crypto_scrypt(passwordData.bytes, (int)passwordData.length, salt.bytes, salt.length, N, r, p, derivedkey.mutableBytes,derivedkey.length, &stop);
    // Bad scrypt parameters
    if (status == -1) {
        NSLog(@"Bad scrypt parameters");
        return nil;
    }
    NSData *derivedhalf2 = [derivedkey subdataWithRange:NSMakeRange(32, 32)];
    NSData *iv = [derivedkey subdataWithRange:NSMakeRange(0, 16)];
    
    NSData *encryptedData = [NSData decodeBase64:encryptedMnemonicCode];
    NSData *decryptedData = [encryptedData aesDecrypt:derivedhalf2 iv:iv];
    
    NSString *decryptedMnemonicCode = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSLog(@"decrypted=%@",decryptedMnemonicCode);
    if (!decryptedMnemonicCode) {
        NSLog(@"Invalid Password");
        return nil;
    }
    NSArray *mnemonicCodes = [decryptedMnemonicCode componentsSeparatedByString:@" "];
    // 验证address是否一致
    NSData *seed = [[MnemonicCode shareInstance] toSeed:mnemonicCodes withPassphrase:@""];
    ONTDeterministicKey *rootKey = [[ONTDeterministicKey alloc] initWithSeed:seed];
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[ChildNumber alloc] initWithPath:44 Hardened:YES]];
    [paths addObject:[[ChildNumber alloc] initWithPath:1024 Hardened:YES]];
    [paths addObject:[[ChildNumber alloc] initWithPath:0 Hardened:YES]];
    [paths addObject:[[ChildNumber alloc] initWithPath:0 Hardened:NO]];
    [paths addObject:[[ChildNumber alloc] initWithPath:0 Hardened:NO]];
    
    ONTECKey *ecKey = [[rootKey Derive:paths] toECKey];
    ONTPublicKey *publicKey = [[ONTPublicKey alloc] initWithData:ecKey.publicKeyAsData];
    if (![publicKey.toAddress.address isEqualToString:address]) {
        NSLog(@"Invalid Address");
        return nil;
    }
    
    return decryptedMnemonicCode;
}
// 加密
+(NSString *)encryptMnemonicCode:(NSString *)mnemonicCode password:(NSString *)password address:(NSString *)address{
    int N = 4096;
    int r = 8;
    int p = 8;
    int dkLen = 64;
    char stop = 0;
    
    NSData *passwordData = [[password precomposedStringWithCompatibilityMapping] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *adressHashTmp = [address dataUsingEncoding:NSUTF8StringEncoding].SHA256_2;
    NSData *salt = [adressHashTmp subdataWithRange:NSMakeRange(0, 4)];
    
    NSMutableData *derivedkey = [NSMutableData dataWithLength:dkLen];
    int status = crypto_scrypt(passwordData.bytes, (int)passwordData.length, salt.bytes, salt.length, N, r, p, derivedkey.mutableBytes,derivedkey.length, &stop);
    // Bad scrypt parameters
    if (status == -1) {
        NSLog(@"Bad scrypt parameters");
    }
    NSData *derivedhalf2 = [derivedkey subdataWithRange:NSMakeRange(32, 32)];
    NSData *iv = [derivedkey subdataWithRange:NSMakeRange(0, 16)];
    
    NSData *mnemonicCodeData = [mnemonicCode dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"key:[%@],iv:[%@],data:[%@]",derivedhalf2.hexString,iv.hexString,mnemonicCodeData.hexString);
    mnemonicCodeData = [mnemonicCodeData aesEncrypt:derivedhalf2 iv:iv];
    
    NSString *encryptedMnemonicCode = [[NSString alloc] initWithData:mnemonicCodeData.base64 encoding:NSUTF8StringEncoding];
    NSLog(@"encrypted=%@",encryptedMnemonicCode);
    
    return encryptedMnemonicCode;
}
@end
