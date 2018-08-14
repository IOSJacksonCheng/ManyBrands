//
//  HandleRequestTool.h
//  BaiYeSheng
//
//  Created by 指意达 on 2018/1/17.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleRequestTool : NSObject
+ (BOOL)requestFromPhoneIsSuccessfulWithResponse:(id)responseObject;
+ (BOOL)requestFailureIs10012WittReponse:(id)responseObject;
+ (BOOL)requestFailureIs20001WittReponse:(id)responseObject;
+ (id)requestSuccessGetResult:(id)responseObject;
@end
