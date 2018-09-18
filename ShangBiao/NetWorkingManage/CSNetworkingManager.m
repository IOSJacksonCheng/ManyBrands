//
//  CSNetworkingManager.m
//  NewScan
//
//  Created by 指意达 on 16/11/3.
//  Copyright © 2016年 YiDa. All rights reserved.
//

#import "CSNetworkingManager.h"
#import "AFNetworking.h"
#import "LoginInViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import "HandleRequestTool.h"
NSString * const TokenRefreshFailureRemindMessage = @"网络错误,请检查网络";
@implementation CSNetworkingManager
+ (NSString *)getBaseUrl {
    
    return CSBaseURL;
    
}
/** 发送get请求 */
+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:CSGetToken forHTTPHeaderField:@"token"];
   
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    CSLog(@"%@",url);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"get参数:%@",paramDic);
    [manager GET:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 CSLog(@"返回结果%@", responseObject);
        success(responseObject);
        
        
        CSLog(@"errstr:%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
       CSLog(@"get请求失败:%@", error.userInfo);
        CSLog(@"get请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
        
    }];
    
    
    
}
/** 发送post请求 */
+ (void)sendPostRequestWithUrl:(NSString *)urlStr Parpmeters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
  
    
    [manager.requestSerializer setValue:CSGetToken forHTTPHeaderField:@"token"];
    

    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    

    CSLog(@"%@",url);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"POST参数:%@",paramDic);
    [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         CSLog(@"返回结果%@", responseObject);
        success(responseObject);
       
      
    CSLog(@"errstr:%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
         CSLog(@"post请求失败:%@", error.userInfo);
        CSLog(@"post请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
        
    }];
}

+ (void)sendPutRequestWithUrl:(NSString *)urlStr parpameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (paramDic == nil) {
        paramDic = [NSMutableDictionary dictionary];
    }
   
    [manager.requestSerializer setValue:CSGetToken forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    

    CSLog(@"%@",url);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"PUT参数:%@",paramDic);
    [manager PUT:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          CSLog(@"返回结果%@", responseObject);
        success(responseObject);
    
        
        CSLog(@"errstr:%@",responseObject[@"message"]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
         CSLog(@"PUT请求失败:%@", error.userInfo);
        CSLog(@"PUT请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
        
    }];
    
}

/** 发送delete请求 */
+ (void)sendDeleteRequestWithUrl:(NSString *)urlStr WithParameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (paramDic == nil) {
        paramDic = [NSMutableDictionary dictionary];
    }
    
    [manager.requestSerializer setValue:CSGetToken forHTTPHeaderField:@"token"];
    

    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    CSLog(@"%@",url);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"DELETE参数:%@",paramDic);
    [manager DELETE:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         CSLog(@"返回结果%@", responseObject);
        success(responseObject);
        
       
     
        CSLog(@"errstr:%@",responseObject[@"message"]);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        CSLog(@"DELETE请求失败:%@", error.userInfo);
        CSLog(@"DELETE请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
        
    }];
    
}

/** 发送post上传图片请求 */
+ (void)sendPostForUploadImageWithUrl:(NSString *)urlStr headerImageFilePath:(NSString *)filePath fileName:(NSString *)fileName parpameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (paramDic == nil) {
        paramDic = [NSMutableDictionary dictionary];
    }
    [manager.requestSerializer setValue:CSGetToken forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    CSLog(@"上传图片地址:%@",url);
    [manager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"img" fileName:fileName mimeType:@"image/png" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        CSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //请求成功
    
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        //请求失败
        
        CSLog(@"图像上传失败:%@", error.userInfo);
      
        
    }];
}











@end
