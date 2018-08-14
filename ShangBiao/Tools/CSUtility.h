//
//  CSUtility.h
//  Personality Customization
//
//  Created by 指意达 on 16/8/26.
//  Copyright © 2016年 YiDa. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GpsBlock)(NSString * lon, NSString * lat);
@interface CSUtility : NSObject


/** 设置错误提示信息 */
+ (void) showWrongMessageWithTitle:(NSString *)title;

/** 判断字符串是否为空 */
+ (BOOL) characterIsBlankString:(NSString *)string;

/** 获得当前日期  */
+ (NSString *) getCurrentDate;

+ (BOOL)judgeStringValid:(NSString *)string;


+ (NSDate *)convertStringIntoDate:(NSString *)dateString;

+ (NSString *)convertNSDateIntoString:(NSDate *)date;
+ (NSString *)getFirstDayWithMonth:(NSString *)month;
+ (NSString *)getLastDayWithMonth:(NSString *)month;

///** AES加密  */
//+ (NSString *)encryptAESStringWithOriginalString:(NSString *)string;
//
///** aes解密  */
//+ (NSString *)decryptAESStringWithOriginalString:(NSString *)string;

+ (UIViewController *)getCurrentViewController;

+(NSString *)return8LetterAndNumber;
+ (NSString *) getCurrentTimeHour;
//
//+ (NSString *)encryptAESStringWithFixKeyWithOriginalString:(NSString *)string;
//+ (NSString *)decryptAESStringWithFixKeyOriginalString:(NSString *)string;
+ (void)compareTimeGetDifferent;
+ (BOOL)judgeTimeIsValidWIthBeginTime:(NSString *)beginTime WithEndTime:(NSString *)endTime;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
+ (void)convertLocationWithLat:(NSString *)lat WithLon:(NSString *)lon WithType:(NSString *)type WithGps:(GpsBlock)block;

@end

