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

#define CSBaseURL @"http://www.niusb.com"
#define UploadURL @"index.php/api/uploadify"
#define CSInternetFailure [CSUtility showWrongMessageWithTitle:@"网络错误，请检查网络."];
#define CSShowWrongMessage [CSUtility showWrongMessageWithTitle:responseObject[@"msg"]];

#define CSInternetRequestSuccessful [HandleRequestTool requestFromPhoneIsSuccessfulWithResponse:responseObject]

#define CustomWrongMessage(message) [CSUtility showWrongMessageWithTitle:message];

#define CSGetResult [HandleRequestTool requestSuccessGetResult:responseObject]
/** 登录 */
#define CSLoginURL @"index.php/api/login"
/** 注册 */
#define CSRegisterURL @"index.php/api/user/reg"
/** 发送手机验证码 */
#define CSGetCodeURL @"index.php/api/user/send_sms_reg_code"
/** 获取首页广告 */
#define CSHomePageADURL @"index.php/api/index/getad"

/** 产品明细 */
#define CSProductListURL @"index.php/api/goods"

#define CSProductDetailURL @"index.php/api/goods/goodsinfo"
#endif /* InternetAddress_h */
