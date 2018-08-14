//
//  InternetAddress.h
//  BaiYeSheng
//
//  Created by 指意达 on 2018/1/15.
//  Copyright © 2018年 Yida. All rights reserved.
//

#ifndef InternetAddress_h
#define InternetAddress_h

#define SuccessfulCode 0

#define TokenFailureCode 10012

#define NotSubmitCode 1004

#define CSInternetFailure [CSUtility showWrongMessageWithTitle:@"网络错误，请检查网络."];
#define CSShowWrongMessage [CSUtility showWrongMessageWithTitle:responseObject[@"errstr"]];

#define CSInternetRequestSuccessful [HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:responseObject]

#define CustomWrongMessage(message) [CSUtility showWrongMessageWithTitle:message];

#define CSGetResult [HandleRequestTool requestSuccessGetResult:responseObject]

#define SendGoodsCountStatistisURL @"statistics"

#define HaveFinishedSummaryURL @"summary"

#define SendGoodsDetailInfomationURL @"order"

#define GetMissionURL @"ladings"

#define AppointmentsURL @"appointments"

#define DeliverysURL @"deliverys"

#define OrderSignsURL @"ordersigns"

#define GetCaptchasURL @"captchas"

#define CheckCaptchURL @"checkcaptchas"

#define RegisterURL @"users"

#define RebackPasswordURL @"passwords"

#define LoginInURL @"logins"

#define TrackMessageURL @"track"

#define RefreshLocationsURL @"locations"

#define ConvertsLocationsURL @"converts"

#define ChangeCodeURL @"userpassword"

#define GetServeTimeURL @"time"

#define RefreshTokenURL @"token"

#define RegisterTokenURL @"tokens"

#define UploadURL @"uploads"

#endif /* InternetAddress_h */
