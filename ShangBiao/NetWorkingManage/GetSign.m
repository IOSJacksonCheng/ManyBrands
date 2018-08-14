////
////  GetSign.m
////  BaiYeSheng
////
////  Created by 指意达 on 2018/1/17.
////  Copyright © 2018年 Yida. All rights reserved.
////
//
//#import "GetSign.h"
//#import <CommonCrypto/CommonDigest.h>
//@implementation GetSign
//+ (NSString *)getSignByMe {
//    
//    
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//    
//    NSTimeInterval a=[date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
//    
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", a + csTimeDifferent];
//    
//    NSString *randString = [CSUtility return8LetterAndNumber];
//    
//    NSString *sign = [CSUtility encryptAESStringWithOriginalString:[NSString stringWithFormat:@"%@%@%@%@", CSAPPID, GetDeveloperKey, randString, timeString]];
//    
//    CSLog(@"sign=%@", sign);
//    
//    return sign;
//    
//    
//    
//}
//+ (NSString *)getAESDecryptionKey {
//    
//    //    NSString *recordTime = [CSUtility getCurrentTimeHour];
//    
//    NSString *originString = [NSString stringWithFormat:@"%@", AESDecryptionKey];
//    
//    NSString *sign=[[self getSha1:originString] substringToIndex:16];
//    CSLog(@"AESDercyKey:%@", sign);
//    return sign;
//}
//
//+ (NSString *)getAESDecryptionIV {
//    //    NSString *recordTime = [CSUtility getCurrentTimeHour];
//    
//    NSString *originString = [NSString stringWithFormat:@"%@", AESDecryptionIV];
//    
//    
//    NSString *sign=[[self getSha1:originString] substringToIndex:16];
//    
//    CSLog(@"AESDercyIV:%@", sign);
//    return sign;
//}
//+ (NSString *) getSha1:(NSString *)input
//{
//    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:input.length];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    
//    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
//        [output appendFormat:@"%02x", digest[i]];
//    }
//    
//    return output;
//}
//
//@end
