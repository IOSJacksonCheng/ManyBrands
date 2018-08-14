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
#import "GetSign.h"
#import <AdSupport/ASIdentifierManager.h>
#import "HandleRequestTool.h"
NSString * const TokenRefreshFailureRemindMessage = @"网络错误,请检查网络";
@implementation CSNetworkingManager
+ (NSString *)getBaseUrl {
    NSString *baseUrl = nil;
    if (TESTMODEL) {
        
        if (CodeModel) {
            
            baseUrl = @"huangjc.leather168.com";
            
        } else {
            
          
            
            baseUrl = @"guojiazi.com";
            
           
            
        }
        
        return [NSString stringWithFormat:@"http://api.%@/%@",baseUrl, APPVERSION];
        
        
    } else {
        return [NSString stringWithFormat:@"https://api.%@/%@",baseUrl, APPVERSION];
        
    }
    
    
}
/** 发送get请求 */
+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    if (![self judgeTokenIsValid]) {
        //token invalid
        [self refreshTokenWithSuccessBlock:^(id tokenObject) {
            
         if ([HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:tokenObject]) {
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             
             
             [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
             
             NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
             CSLog(@"%@&&token=%@",url, CSToken);
             CSLog(@"当前调用函数：%s",__func__);
             CSLog(@"get参数:%@",paramDic);
             [manager GET:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 
                 success(responseObject);
                 
                 [self submitAgainWithJson:responseObject];
                          CSLog(@"返回结果%@", responseObject);
                 CSLog(@"errstr:%@",responseObject[@"message"]);
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 
                 failure(error);
                 CSLog(@"get请求失败:%@", error.userInfo);
                 CSLog(@"get请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
                 
             }];
             
         }else {
             success(tokenObject);
         }
            
        } WithFailure:^(NSError *error) {
            
            failure(error);
        }];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    CSLog(@"%@&&token=%@",url, CSToken);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"get参数:%@",paramDic);
    [manager GET:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 CSLog(@"返回结果%@", responseObject);
        success(responseObject);
        
        [self submitAgainWithJson:responseObject];
        
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
    if (![self judgeTokenIsValid]) {
        //invalid
        [self refreshTokenWithSuccessBlock:^(id tokenObject) {
            
            if ([HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:tokenObject]) {
                [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
                
                
                NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
                
                CSLog(@"返回结果%@", tokenObject);
                CSLog(@"%@&&token=%@",url, CSToken);
                CSLog(@"当前调用函数：%s",__func__);
                CSLog(@"POST参数:%@",paramDic);
                [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             CSLog(@"返回结果%@", responseObject);
                    success(responseObject);
                    [self submitAgainWithJson:responseObject];
                    
                    CSLog(@"errstr:%@",responseObject[@"message"]);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    failure(error);
                    
                      CSLog(@"post请求失败:%@", error.userInfo);
                    CSLog(@"post请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
                    
                }];
                
            }else {
                success(tokenObject);
            }
            
        } WithFailure:^(NSError *error) {
            
            failure(error);
        }];
        return;
    }
    
    [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];

    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    

    CSLog(@"%@&&token=%@",url, CSToken);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"POST参数:%@",paramDic);
    [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         CSLog(@"返回结果%@", responseObject);
        success(responseObject);
         [self submitAgainWithJson:responseObject];
      
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
    if (![self judgeTokenIsValid]) {
        //invalid
        [self refreshTokenWithSuccessBlock:^(id tokenObject) {
            
            if ([HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:tokenObject]) {
                [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
                
                NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
                
                         CSLog(@"返回结果%@", tokenObject);
                CSLog(@"%@&&token=%@",url, CSToken);
                CSLog(@"当前调用函数：%s",__func__);
                CSLog(@"PUT参数:%@",paramDic);
                [manager PUT:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             CSLog(@"返回结果%@", responseObject);
                    success(responseObject);
                    
                    [self submitAgainWithJson:responseObject];
                    
                    CSLog(@"errstr:%@",responseObject[@"message"]);
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                      CSLog(@"PUT请求失败:%@", error.userInfo);
                    CSLog(@"PUT请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
                    
                }];
                
            }else {
                success(tokenObject);
            }
            
        } WithFailure:^(NSError *error) {
            
            failure(error);
        }];
        return;
    }
     [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    

    CSLog(@"%@&&token=%@",url, CSToken);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"PUT参数:%@",paramDic);
    [manager PUT:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          CSLog(@"返回结果%@", responseObject);
        success(responseObject);
        
        [self submitAgainWithJson:responseObject];
        
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
    if (![self judgeTokenIsValid]) {
        //invalid
        [self refreshTokenWithSuccessBlock:^(id tokenObject) {
            
            if ([HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:tokenObject]) {
                [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
                
                NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
                  CSLog(@"返回结果%@", tokenObject);
                CSLog(@"%@&&token=%@",url, CSToken);
                CSLog(@"当前调用函数：%s",__func__);
                CSLog(@"DELETE参数:%@",paramDic);
                [manager DELETE:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      CSLog(@"返回结果%@", responseObject);
                    success(responseObject);
                    
                    [self submitAgainWithJson:responseObject];
                    
                    CSLog(@"errstr:%@",responseObject[@"message"]);
                    
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                       CSLog(@"DELETE请求失败:%@", error.userInfo);
                    CSLog(@"DELETE请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
                    
                }];
                
            }else {
                success(tokenObject);
            }
            
        } WithFailure:^(NSError *error) {
            
            failure(error);
        }];
        return;
    }
        [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
    CSLog(@"%@&&token=%@",url, CSToken);
    CSLog(@"当前调用函数：%s",__func__);
    CSLog(@"DELETE参数:%@",paramDic);
    [manager DELETE:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         CSLog(@"返回结果%@", responseObject);
        success(responseObject);
        
        [self submitAgainWithJson:responseObject];
     
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
    if (![self judgeTokenIsValid]) {
        //invalid
        [self refreshTokenWithSuccessBlock:^(id tokenObject) {
            
            if ([HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:tokenObject]) {
                [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
                
//                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                NSString *url = [NSString stringWithFormat:@"%@/%@", [self getBaseUrl],UploadURL];
             
                CSLog(@"%@&&token=%@",url, CSToken);
                [manager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:fileName mimeType:@"image/png" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    //打印下上传进度
                    CSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    //请求成功
                    
                    [self submitAgainWithJson:responseObject];
                    
                    success(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                    //请求失败
                    
                    CSLog(@"图像上传失败:%@", error.userInfo);
                    
                    
                }];
                
            }else {
                success(tokenObject);
            }
            
        } WithFailure:^(NSError *error) {
            
            failure(error);
        }];
        return;
    }
        [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];

//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

     NSString *url = [NSString stringWithFormat:@"%@/%@", [self getBaseUrl],UploadURL];
 CSLog(@"%@&&token=%@",url, CSToken);
    [manager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:fileName mimeType:@"image/png" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        CSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //请求成功
        
        [self submitAgainWithJson:responseObject];
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        //请求失败
        
        CSLog(@"图像上传失败:%@", error.userInfo);
      
        
    }];
}
+ (void)submitAgainWithJson:(id)responseobject {
    if ([CSSubmitAgainHaveHappened isEqualToString:@"20001HaveHappened"]) {
        return;
    }
    
    if ([HandleRequestTool requestFailureIs20001WittReponse:responseobject]) {
         [[NSUserDefaults standardUserDefaults] setValue:@"20001HaveHappened" forKey:@"20001HaveHappened"];
       
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"请重新登录" message:@"长时间未操作，或在其它设备上登录，为了保证您的安全请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"20001HaveHappened"];
            LoginInViewController *new = [LoginInViewController new];
            
            [[CSUtility getCurrentViewController] presentViewController:new animated:YES completion:nil];
           
        }];

        [alercConteoller addAction:actionYes];

        [[CSUtility getCurrentViewController] presentViewController:alercConteoller animated:YES completion:nil];
    }
    
    
}

+ (void)refreshTokenWithSuccessBlock:(refreshTokenSuccess)successToken WithFailure:(refreshTokenFailure)failureToken {
    
    
         AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
         [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
    
    NSMutableDictionary *paramDic = @{}.mutableCopy;
    
    paramDic[@"sign"] = @"";
    
         NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl], RefreshTokenURL];
    
         CSLog(@"%@&&token=%@",url, CSToken);
    [manager PUT:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (CSInternetRequestSuccessful) {
            NSString *token = [NSString stringWithFormat:@"%@",CSGetResult[@"token"]];
            
            [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"CSToken"];
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", CSGetResult[@"expireTime"]] forKey:@"CSTokenExpireTime"];
            
        }
        successToken(responseObject);
        
        CSLog(@"当前调用函数：%s",__func__);
        CSLog(@"刷新token参数:%@",paramDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          CSLog(@"刷新token失败:%@", error.userInfo);
    }];
    
    

    
   
}


+ (void)registerAPPToServerWithBlock:(tokenRequestBlock)tokenRefresh {
    if (![CSUtility characterIsBlankString:CSAPPID] && [CSAPPIDVERSION isEqualToString:APPVERSION]) {
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    paramDic[@"devkey"] = GetDeveloperKey;
    
//    paramDic[@"idcode"] = [CSUtility encryptAESStringWithOriginalString:[[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]];
    
    paramDic[@"device"] = [UIDevice currentDevice].systemVersion;
    
    paramDic[@"os"] = @"ios";
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl], RegisterTokenURL];
     CSLog(@"当前调用函数：%s",__func__);
      CSLog(@"post请求URL：%@\n post参数:%@", url,paramDic);
    [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if (CSInternetRequestSuccessful) {
            NSString *token = [NSString stringWithFormat:@"%@",CSGetResult[@"token"]];
            
            [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"CSToken"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"appId"]] forKey:@"CSAPPID"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", CSGetResult[@"expireTime"]] forKey:@"CSTokenExpireTime"];
            
             [[NSUserDefaults standardUserDefaults] setValue:APPVERSION forKey:@"CSAPPIDVERSION"];
            tokenRefresh(YES);
        } else {
            CustomWrongMessage(TokenRefreshFailureRemindMessage);
            tokenRefresh(NO);
        }
        
   
        CSLog(@"\npost请求URL：%@\nresponseObject:%@",url,responseObject);
        CSLog(@"errstr:%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        tokenRefresh(NO);
        
        CSLog(@"%@", error.userInfo);
        
        CSLog(@"post请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
        
    }];
}


+ (BOOL)judgeTokenIsValid {
    //yyyy-MM-dd HH:mm:ss
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *tokenTimeDete = [format dateFromString:CSTokenExpireTime];
  
    NSString *currentTime = [format stringFromDate:[NSDate date]];;
    CSLog(@"!!!!!!tokenTime:%@", CSTokenExpireTime);
    CSLog(@"!!!!currentTime:%@", currentTime);
    NSDate *currentDate = [format dateFromString:currentTime];
    NSComparisonResult result = [tokenTimeDete compare:currentDate];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return YES;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return NO;
    }
    //NSLog(@"Both dates are the same");
    return NO;
    
}
+ (void)getSignServeTimeWithTime:(successBlock)success {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl], GetServeTimeURL];
    
    CSLog(@"%@",url);
    [manager GET:url parameters:[NSMutableDictionary dictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (CSInternetRequestSuccessful) {
            success([NSString stringWithFormat:@"%@", CSGetResult]);
        } else {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a=[date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
            NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
               success(timeString);
        }
        
        CSLog(@"当前调用函数：%s",__func__);
        CSLog(@"get请求URL：%@\n%@",url,responseObject);
        
        CSLog(@"errstr:%@",responseObject[@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
        success(timeString);
        CSLog(@"%@", error.userInfo);
        
        CSLog(@"get请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
    }];
    
    
}
//+ (void)sendGetRequestNoRemaindMessageWithUrl:(NSString *)urlStr parameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    if (paramDic == nil) {
//
//        paramDic = [NSMutableDictionary dictionary];
//
//    }
//
//    [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
//
//
//    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
//
//    CSLog(@"%@&&token=%@",url, CSToken);
//
//    [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        success(responseObject);
//
//        CSLog(@"当前调用函数：%s",__func__);
//        CSLog(@"\npost请求URL：%@\nresponseObject:%@",url,responseObject);
//        CSLog(@"post参数:%@",paramDic);
//        CSLog(@"errstr:%@",responseObject[@"message"]);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        failure(error);
//
//        CSLog(@"post请求URL：%@\n post参数:%@", url,paramDic);
//
//        CSLog(@"%@", error.userInfo);
//
//        CSLog(@"post请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
//
//    }];
//}
//+ (void)sendDeleteRequestNoRemaindMessageWithUrl:(NSString *)urlStr WithParameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    if (paramDic == nil) {
//        paramDic = [NSMutableDictionary dictionary];
//    }
//
//    [manager.requestSerializer setValue:CSToken forHTTPHeaderField:@"token"];
//
//    NSString *url = [NSString stringWithFormat:@"%@/%@",[self getBaseUrl],urlStr];
//    CSLog(@"%@&&token=%@",url, CSToken);
//    [manager DELETE:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        success(responseObject);
//
//
//        CSLog(@"当前调用函数：%s",__func__);
//        CSLog(@"\nDELETE请求URL：%@\nresponseObject:%@",url,responseObject);
//        CSLog(@"DELETE参数:%@",paramDic);
//        CSLog(@"errstr:%@",responseObject[@"message"]);
//
//
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//        CSLog(@"%@", error.userInfo);
//        CSLog(@"DELETE请求URL：%@\n get参数:%@", url,paramDic);
//        CSLog(@"DELETE请求失败:%@\n调用函数：%s",[error userInfo][@"com.alamofire.serialization.response.error.string"],__func__);
//
//    }];
//
//}

@end
