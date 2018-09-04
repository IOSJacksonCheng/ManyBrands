//
//  CSNetworkingManager.h
//  NewScan
//
//  Created by 指意达 on 16/11/3.
//  Copyright © 2016年 YiDa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CSNetworkingManager : NSObject
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

/** 发送get请求 */
+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;

/** 发送post请求 */
+ (void)sendPostRequestWithUrl:(NSString *)urlStr Parpmeters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送put请求 */
+ (void)sendPutRequestWithUrl:(NSString *)urlStr parpameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送delete请求 */
+ (void)sendDeleteRequestWithUrl:(NSString *)url WithParameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送post上传图片请求 */
+ (void)sendPostForUploadImageWithUrl:(NSString *)urlStr headerImageFilePath:(NSString *)filePath fileName:(NSString *)fileName parpameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;


@end
