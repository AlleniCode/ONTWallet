//
//  ONTWalletTests.m
//  ONTWalletTests
//
//  Created by zhangyutao on 2018/7/13.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ONTAccount.h"
#import "ONTMnemonicCode.h"
#import "ONTRpcApi.h"

@interface ONTWalletTests : XCTestCase

@end

@implementation ONTWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


// ONT Wallet Tests
/*
 === 【ONTAccount】===
 【name】== ONT-Wallet
 【mnemonicText】== use dinner opinion jewel detail inquiry popular enough diary upper concert identify
 【privateKeyHex】== c3cc0e31af0e085299b38962281fceeb39cca70ac4ecc3bbd46e25154a9fb317
 【WIF】== L3nKDP3Wh3zmVktyFPGFegEUhJrpRcorosqk71X91rmjxnXtAFqb
 【keystore】== {
 "scrypt" : {
 "r" : 8,
 "p" : 8,
 "n" : 4096,
 "dkLen" : 64
 },
 "address" : "AYHaPrwqqyH6SA64ayKtgrKAYRoW5eqLhL",
 "key" : "SF1j0sgL5ZJESA2Ve93OI+nZgBGkDU6yComp4OTl2RGIfyHcnGdq93nX9foioK8O",
 "label" : "ONT-Wallet",
 "type" : "A",
 "algorithm" : "ECDSA",
 "salt" : "fZdmYcHDh690DfxP4ZX+cg==",
 "parameters" : {
 "curve" : "P-256"
 }
 }
 【address】== AYHaPrwqqyH6SA64ayKtgrKAYRoW5eqLhL
 */

/*
 === 【ONTAccount】===
 【name】== ONT-Wallet
 【mnemonicText】== fee door real prize indicate stick awkward wish range night erase apology
 【privateKeyHex】== 75a4b56fc02485d1e3aa819ee781b2bafc93718b91d12d71ec2c2a5e87d1a993
 【WIF】== L1APpZYSXqLepj6DUuQF13bcLcJXKPLnzRwMqA3B7R9ELnCzsmcN
 【keystore】== {
 "scrypt" : {
 "r" : 8,
 "p" : 8,
 "n" : 4096,
 "dkLen" : 64
 },
 "address" : "AUq4ccLkTvcsY1P8kPsZP6EQtk1qikbh36",
 "key" : "1W2xmf8uvdeslsz0ONjzaPL5g+cq6qMiop+Cz6pzkiNm0FNq7bzvNSgGKxXN9Afm",
 "label" : "ONT-Wallet",
 "type" : "A",
 "algorithm" : "ECDSA",
 "salt" : "SlTafHmb0\/Qls47AOWxIMg==",
 "parameters" : {
 "curve" : "P-256"
 }
 }
 【address】== AUq4ccLkTvcsY1P8kPsZP6EQtk1qikbh36
 */
- (void)testCreateNewWallet {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT123ont"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
    NSLog(@"=== 【ONTAccount】=== \n%@", account.encryptMnemonicText);
    NSString *mnemonicText = [ONTMnemonicCode decryptMnemonicCode:account.encryptMnemonicText password:@"ONT123ont" address:account.address.address];
    
    if (![account.mnemonicText isEqualToString:mnemonicText]) {
        XCTFail(@"助记词解析错误！！！");
    }
}

- (void)testImportWalletWithMnemonic {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" mnemonicText:@"use dinner opinion jewel detail inquiry popular enough diary upper concert identify"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
}

- (void)testImportWalletWithPrivateKeyHex {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" privateKeyHex:@"c3cc0e31af0e085299b38962281fceeb39cca70ac4ecc3bbd46e25154a9fb317"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
}

- (void)testImportWalletWithWif {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L3nKDP3Wh3zmVktyFPGFegEUhJrpRcorosqk71X91rmjxnXtAFqb"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
}

- (void)testImportWalletWithKeystore {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet-1" password:@"ONT123ont" keystore:@"{\"address\":\"AGhTEEidUJxWgYMgXV7R4u979XNTwFMW3E\",\"scrypt\":{\"r\":8,\"p\":8,\"n\":4096,\"dkLen\":64},\"parameters\":{\"curve\":\"secp256r1\"},\"label\":\"ONT-11\",\"key\":\"d3CMcJzNc\\/gtc1RjZs2fOFVX4W96D9CUQl7\\/xNByNf\\/d0etHSDMjigAXFK37BQ3R\",\"type\":\"A\",\"algorithm\":\"ECDSA\",\"salt\":\"a14WS21HV5kLrQHTOIYvWQ==\"}"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
}

- (void)testSignAssetONT {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L2pGnv7waHczPursyuGDCBBU6GuoVBHkKF6uKjeFfiy584LQUqir"];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONT toAddress:@"AatvPQVe1RECTqoAxe9FtSdWGnABVjMExv" amount:3 gasPrice:500 gasLimit:20000];
    NSLog(@"txHex == %@", txHex);
}

- (void)testSignAssetONG {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L2pGnv7waHczPursyuGDCBBU6GuoVBHkKF6uKjeFfiy584LQUqir"];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONG toAddress:@"AatvPQVe1RECTqoAxe9FtSdWGnABVjMExv" amount:3 gasPrice:500 gasLimit:20000];
    NSLog(@"txHex == %@", txHex);
}



@end
