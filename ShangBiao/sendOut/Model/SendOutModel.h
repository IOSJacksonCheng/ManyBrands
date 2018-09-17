//
//  SendOutModel.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/6.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendOutModel : NSObject

@property (nonatomic, strong) NSString *agent;

/** 公告日期  */
@property (nonatomic, strong) NSString *announcementDate;

/** 初审公告期号  */
@property (nonatomic, strong) NSString *announcementIssue;

/**   */
@property (nonatomic, strong) NSString *appDate;

/** 申请人  */
@property (nonatomic, strong) NSString *applicantCn;

/** 商标状态  状态无效  则不能点击*/
@property (nonatomic, getter=isCanUse) BOOL canUse;

/**   */
@property (nonatomic, strong) NSString *goodsCode;

/** 商标类别  */
@property (nonatomic, strong) NSString *intCls;

/** 注册日期  */
@property (nonatomic, strong) NSString *regDate;

/** 注册公告期号  */
@property (nonatomic, strong) NSString *regIssue;

/**  商标号 */
@property (nonatomic, strong) NSString *regNo;

/**   */
@property (nonatomic, strong) NSString *tmImg;

/** 商标名  */
@property (nonatomic, strong) NSString *tmName;

@property (nonatomic, strong) NSString *willBuyTextField;

@property (nonatomic, assign) BOOL chooseSelect;

@property (nonatomic, assign) BOOL willSendOut;
@end
