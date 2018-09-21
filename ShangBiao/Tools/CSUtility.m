//
//  CSUtility.m
//  Personality Customization
//
//  Created by 指意达 on 16/8/26.
//  Copyright © 2016年 YiDa. All rights reserved.
//

#import "CSUtility.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "LoginInViewController.h"
#import "CSCommonTabBarController.h"

#define LOAD_LABEL                     NSLocalizedString(@"登录过期，请重新登录",)
@implementation CSUtility
{
    MBProgressHUD *_mbProgressHUD;
}


+ (void) showWrongMessageWithTitle:(NSString *)title
{
    [[self alloc] showWrongMessageWithTitle:title];
    
}

- (void) showWrongMessageWithTitle:(NSString *)title
{
    
   
    AppDelegate* delegate = nil;
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _mbProgressHUD = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    _mbProgressHUD.mode = MBProgressHUDModeText;
    
    _mbProgressHUD.color = CSColorRGBA(228, 228, 229, 1);

    _mbProgressHUD.labelFont = csCharacterFont_14;
    _mbProgressHUD.labelColor = csBlackColor;
    
    _mbProgressHUD.detailsLabelFont = csCharacterFont_14;
    
    _mbProgressHUD.detailsLabelColor = csBlackColor;
    
    if (![title isKindOfClass:[NSString class]]) {
        
        title = [NSString stringWithFormat:@"%@", title];
        
        
    }
    
    if([self characterIsBlankString:title])
    {
        _mbProgressHUD.detailsLabelText = LOAD_LABEL;
    }
    else
    {
        if (title.length > 19) {
            
            _mbProgressHUD.detailsLabelText = title;
            
        } else {
        
            _mbProgressHUD.labelText = title;
            
        }
        
    }
    
    [_mbProgressHUD hide:YES afterDelay:1.5];
    
}
+ (BOOL)characterIsBlankString:(NSString *)string {
    return [[self alloc] characterIsBlankString:string];
}
- (BOOL)characterIsBlankString:(NSString *)string {
    
   
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        
        string = [NSString stringWithFormat:@"%@", string];
        
    }

    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }

    return NO;
    
}
+ (NSString *) getCurrentTimeHour {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    //ddyyyyHHMM
    [formatter setDateFormat:@"ddYYYYHHMM"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
   
    return currentTime;
}
+ (NSString *) getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    return currentTime;
}

+ (BOOL)judgeStringValid:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    
    BOOL valid = [scan scanInt:&val] && [scan isAtEnd];
    if (valid) {
        return YES;
    } else {
        
        float val1;
        return [scan scanFloat:&val1] && [scan isAtEnd];
        
        
    }
}




+ (NSDate *)convertStringIntoDate:(NSString *)dateString {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:dateString];
    return date;
}
+ (NSString *)convertNSDateIntoString:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:date];
    
    return currentTime;
}
+ (NSString *)getFirstDayWithMonth:(NSString *)month {
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:month];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];


    return beginString;
}
+ (NSString *)getLastDayWithMonth:(NSString *)month {
    if ([month isEqualToString:@"2017-12"]) {
        return @"2017-12-31";
    }
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM"];
    
    NSDate *newDate=[format dateFromString:month];
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
  
    NSString *endString = [myDateFormatter stringFromDate:endDate];
 
    return endString;
}
- (BOOL)isNumber:(NSString *)string {
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//+ (NSString *)encryptRSAStringWithOriginalString:(NSString *)string {
//    NSString *publicKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAks5w/JnGYJN0TYaqXnax205rPB43up68fBE7rtDU42/nbXZnbWYdmtpNJo/CQB3LW4fmcRBrCkZkjFTG/yv9XOnHWPiVr3IXJ/N4vsflEMQz2ltMwaAN64+1513VZhK0mnV9C4HxvIG34FQN7dWP9yRFcAsSkXE7rkDhIPF2F+Jg7dH0BiEw7+SZMXytLuAvwCUbOG/k0KVHrRHJdOveMvIcOSFYEbOg3ntEVZsJa8/CrWcvnZCv8Z2YAPZCCOY9+FKTUl/E4qrp3eF3k/GzqlHcEQlgln/r4AqIqxqUto3ZNO7CmCDa/JE++oNYMKqFcBsThEDI1KOvSKasPUwc3wIDAQAB";
//    return [RSA encryptString:string publicKey:publicKey];
//}
//+ (NSString *)encryptAESStringWithFixKeyWithOriginalString:(NSString *)string {
//    AESCipher *new = [AESCipher new];
//    new.iv = @"A-16-Byte-String";
//    return aesEncryptString(string, @"16BytesLengthKey");
//}
//+ (NSString *)decryptAESStringWithFixKeyOriginalString:(NSString *)string {
//    AESCipher *new = [AESCipher new];
//    new.iv = @"A-16-Byte-String";
//    return aesDecryptString(string, @"16BytesLengthKey");
//}
//+ (NSString *)encryptAESStringWithOriginalString:(NSString *)string {
//    AESCipher *new = [AESCipher new];
//    new.iv = [GetSign getAESDecryptionIV];
//    return aesEncryptString(string, [GetSign getAESDecryptionKey]);
//}
//
//+ (NSString *)decryptAESStringWithOriginalString:(NSString *)string {
//    AESCipher *new = [AESCipher new];
//    new.iv = [GetSign getAESDecryptionIV];
//    return aesDecryptString(string, [GetSign getAESDecryptionKey]);
//}


+ (UIViewController *)getCurrentViewController {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[CSCommonTabBarController class]]) {
        result = [(CSCommonTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
//返回16位大小写字母和数字
+(NSString *)return8LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:8];
    for (int i = 0; i < 8; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}
//+ (void)compareTimeGetDifferent {
//    [CSNetworkingManager getSignServeTimeWithTime:^(id responseObject) {
//        
//        NSString *serveTime = responseObject;
//        
//        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        
//        NSTimeInterval currentTime = [date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
//        NSInteger IntTime = currentTime;
//        
//        NSTimeInterval serveTimeInterval = serveTime.longLongValue;
//        
//        double differentTime = serveTimeInterval - IntTime;
//        
//        [[NSUserDefaults standardUserDefaults] setDouble:differentTime forKey:@"csTimeDifferent"];
//        
//        
//    }];
//}
+ (BOOL)judgeTimeIsValidWIthBeginTime:(NSString *)beginTime WithEndTime:(NSString *)endTime {
    //yyyy-MM-dd HH:mm:ss
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate *beginTimeDete = [format dateFromString:beginTime];
    
    NSDate *endTimeDate = [format dateFromString:endTime];
    
    NSComparisonResult result = [endTimeDate compare:beginTimeDete];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return YES;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return NO;
    }
    //NSLog(@"Both dates are the same");
    return YES;
    
}
+ (void)showLoginViewController {
    LoginInViewController *new = [LoginInViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:new];
    
    [[self getCurrentViewController] presentViewController:navi animated:YES completion:nil];
}
+(void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 将图片写入文件
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"images"];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:imageDocPath];
    if (!exist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    [imageData writeToFile:[imageDocPath stringByAppendingPathComponent:imageName] atomically:NO];
}

+ (NSMutableArray *)readLocalSuperClassIdJasonFile {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"superClassId" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        CSLog(@"路径对的");
    }
    NSError *error = nil;
    NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
           CSLog(@"解析错误:%@", error.userInfo);
    }
 
    CSLog(@"%@", dataArray);
    
    return dataArray;

   
}
+ (NSMutableArray *)readLocalCategoryJasonFile {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        CSLog(@"路径对的");
    }
    NSError *error = nil;
    NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        CSLog(@"解析错误:%@", error.userInfo);
    }
    
    CSLog(@"%@", dataArray);
    
    return dataArray;
}
@end

