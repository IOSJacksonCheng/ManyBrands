//
//  HandleRequestTool.m
//  BaiYeSheng
//
//  Created by 指意达 on 2018/1/17.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import "HandleRequestTool.h"

@implementation HandleRequestTool
+ (BOOL)requestFromPhoneIsSuccessfulWithResponse:(id)responseObject {
    int state = [responseObject[@"status"] intValue];
    
    if (state == SuccessfulCode) {
        return YES;
    }
    return NO;
}
+ (BOOL)requestFailureIs10012WittReponse:(id)responseObject {
    int state = [responseObject[@"errno"] intValue];
    if (state == TokenFailureCode) {
        return YES;
    }
    return NO;
}
+ (BOOL)requestFailureIs20001WittReponse:(id)responseObject {
    int state = [responseObject[@"errno"] intValue];
    if (state == NotSubmitCode) {
        return YES;
    }
    ;
    return NO;
}
+ (id)requestSuccessGetResult:(id)responseObject {
    return responseObject[@"data"];
}
@end
