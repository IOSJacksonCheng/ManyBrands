//
//  ApplyPersonListViewController.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSBaseViewController.h"

@interface ApplyPersonListViewController : CSBaseViewController
@property(nonatomic,copy) void(^onGetResult)(NSString *memberId,NSString *memberName);
@property (nonatomic, assign) BOOL fromRegister;
@end
