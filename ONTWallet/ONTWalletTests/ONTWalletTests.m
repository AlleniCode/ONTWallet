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
 【mnemonicText】== club reflect ketchup rookie adapt copy produce object melody inmate century exhibit
 【encryptMnemonicText】== BbJjFCYTd6im1PCZGrit+7cjSi0Us9H5509rf4k4t/ahdGj94s4mzVHH/3NJoL48WTMJ3XtHjdu0ugAejNtBxFOkcsn0fvb3BH4OJa5dPP6dMnEeEyIlOkg9dsRMGKPp
 【privateKeyHex】== 442811de66a79e5234193dcfc8be47736acdc5add4307b27ab90047144225744
 【wif】== KyWCTBb5ynzMzPHYaGcWTQW6iPV4dYwugXbQw3vngr9RDST4hepH
 【keystore】== {
 "scrypt" : {
 "r" : 8,
 "p" : 8,
 "n" : 4096,
 "dkLen" : 64
 },
 "address" : "APjeNaCXGAVVXKPe6n8wYgFjeh3mLoqHWV",
 "key" : "mLMLOpaZWhEcKNAN+p8rd43bmxDdY4t4DIK2eh1N2D51qhUCpnFlf4dl+op4uTk6",
 "label" : "ONT-Wallet",
 "type" : "A",
 "algorithm" : "ECDSA",
 "salt" : "\/3qtmiaVilaqMdKVPPOeKA==",
 "parameters" : {
 "curve" : "P-256"
 }
 }
 【address】== APjeNaCXGAVVXKPe6n8wYgFjeh3mLoqHWV
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
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet-1" password:@"ONT123ont" keystore:@"{\"scrypt\" : {\"r\" : 8,\"p\" : 8,\"n\" : 4096,\"dkLen\" : 64},\"address\" : \"APjeNaCXGAVVXKPe6n8wYgFjeh3mLoqHWV\",\"key\" : \"mLMLOpaZWhEcKNAN+p8rd43bmxDdY4t4DIK2eh1N2D51qhUCpnFlf4dl+op4uTk6\",\"label\" : \"ONT-Wallet\",\"type\" : \"A\",\"algorithm\" : \"ECDSA\",\"salt\" : \"\\/3qtmiaVilaqMdKVPPOeKA==\",\"parameters\" : {\"curve\" : \"P-256\"}}"];
    NSLog(@"=== 【ONTAccount】=== \n%@", account.description);
}

- (void)testSignAssetONT {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L2pGnv7waHczPursyuGDCBBU6GuoVBHkKF6uKjeFfiy584LQUqir"];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONT toAddress:@"AatvPQVe1RECTqoAxe9FtSdWGnABVjMExv" amount:@"1" gasPrice:500 gasLimit:20000];
    NSLog(@"ONT txHex == %@", txHex);
}

- (void)testSignAssetONG {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L2pGnv7waHczPursyuGDCBBU6GuoVBHkKF6uKjeFfiy584LQUqir"];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONG toAddress:@"AatvPQVe1RECTqoAxe9FtSdWGnABVjMExv" amount:@"1" gasPrice:500 gasLimit:20000];
    NSLog(@"ONG txHex == %@", txHex);
}

- (void)testSignClaimONG {
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"ONT-Wallet" password:@"ONT1234567890" wif:@"L2pGnv7waHczPursyuGDCBBU6GuoVBHkKF6uKjeFfiy584LQUqir"];
    NSString *txHex = [account makeClaimOngTxWithAddress:account.address.address amount:@"0.001" gasPrice:500 gasLimit:1000];
    NSLog(@"Claim ONG txHex == %@", txHex);
}


@end
