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
#define CSImageBaseURL @"http://tmpic.tmkoo.com"
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
/** 修改密码/忘记密码 */
#define CSForgetCodeAndChangeCodeURL @"index.php/api/user/set_pwd"
/** 发送手机验证码 */
#define CSGetCodeURL @"index.php/api/user/send_sms_reg_code"
/** 获取首页广告 */
#define CSHomePageADURL @"index.php/api/index/getad"

/** 产品列表 */
#define CSProductListURL @"index.php/api/goods"

/** 产品明细 */
#define CSProductDetailURL @"index.php/api/goods/goodsinfo"

/** 标注册号/申请人查询 */
#define CSBrandSearchURL @"index.php/api/entrust/getdata"

/** 标注册号/申请人查询 */
#define CSSendOutBrandURL @"index.php/api/entrust"
/** 图片上传 */
#define CSUploadImageURL @"index.php/api/uploadify"

/** 我的注册 */
#define CSMySendOutRegisterListURL @"index.php/api/user/register"

/** 我的发布 */
#define CSMySendOutListURL @"index.php/api/user/index"

/** 申请人列表 */
#define CSApplyPersonListURL @"index.php/api/register/getproposer"
/** 添加申请人 */
#define CSAddNewApplyPersonURL @"index.php/api/register/proposer"
/** 商标注册 */
#define CSRegisterBrandURL @"index.php/api/register"


/** 修改价格 */
#define CSChangePriceURL @"index.php/api/user/setprice"
/** 商标进度查询 */
#define CSSearchProgressURL @"index.php/api/search/progress"
/** 商标库接口基础查询 */
#define CSSearchBasicURL @"index.php/api/search"
#endif /* InternetAddress_h */
