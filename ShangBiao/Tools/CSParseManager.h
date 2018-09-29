//
//  CSParseManager.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SendOutModel;

@interface CSParseManager : NSObject
+ (NSMutableArray *)getHomeModelArray:(id)responseObject;
+ (NSMutableArray *)getSendOutModelArray:(id)responseObject;
+ (SendOutModel *)getSendOutPreciseModelArray:(id)responseObject;
+ (NSMutableArray *)getMySendOutListModelArray:(id)responseObject;
+ (NSMutableArray *)getApplyPersonListModelArray:(id)responseObject;
+ (NSMutableArray *)getSuperClassListModelArray:(id)responseObject;
+ (NSMutableArray *)getCategoryClassIdListModelArray:(id)responseObject;
+ (NSMutableArray *)getSearchFreeResultListModelArray:(id)responseObject;
@end
