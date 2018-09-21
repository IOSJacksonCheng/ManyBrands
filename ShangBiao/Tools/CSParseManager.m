//
//  CSParseManager.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSParseManager.h"

#import "HomePageModel.h"
#import "SendOutModel.h"
#import "MySendOutListModel.h"
#import "ApplyPersonListModel.h"
#import "SuperClassIdModel.h"
#import "CategoryClassIdModel.h"
@implementation CSParseManager
+ (NSMutableArray *)getCategoryClassIdListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        CategoryClassIdModel *model = [CategoryClassIdModel new];
        model.classId = [self handelInternetString:array[i][@"id"]];
        model.item = [self getCategorySonClassIdListModelArray:array[i][@"item"]];
        model.chooseStatus = NO;
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getCategorySonClassIdListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        CategoryClassIdModel *model = [CategoryClassIdModel new];
        model.classId = [self handelInternetString:array[i][@"id"]];
         model.title = [self handelInternetString:array[i][@"title"]];
        model.item = [self getCategoryGrandsonClassIdListModelArray:array[i][@"item"]];
          model.chooseStatus = NO;
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getCategoryGrandsonClassIdListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        CategoryClassIdModel *model = [CategoryClassIdModel new];
        model.classId = [self handelInternetString:array[i][@"id"]];
        model.title = [self handelInternetString:array[i][@"title"]];
        model.chooseStatus = NO;
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getSuperClassListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        SuperClassIdModel *model = [SuperClassIdModel new];
        model.classId = [self handelInternetString:array[i][@"id"]];
        if (i == 0) {
            model.chooseStatus = YES;
        } else {
               model.chooseStatus = NO;
        }
     
        model.title = [self handelInternetString:array[i][@"title"]];
        
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getApplyPersonListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        ApplyPersonListModel *model = [ApplyPersonListModel new];
        model.personId = [self handelInternetString:array[i][@"id"]];
        
        model.receive_name = [self handelInternetString:array[i][@"receive_name"]];
        
        model.receive_phone = [self handelInternetString:array[i][@"receive_phone"]];
        
        model.templatename = [self handelInternetString:array[i][@"templatename"]];
        
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getMySendOutListModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        MySendOutListModel *model = [MySendOutListModel new];
        model.goods_id = [self handelInternetString:array[i][@"goods_id"]];
        
        model.goods_sn = [self handelInternetString:array[i][@"goods_sn"]];
        
        model.goods_name = [self handelInternetString:array[i][@"goods_name"]];
        
        model.cost_price = [self handelInternetString:array[i][@"cost_price"]];
        model.original_img = [self handelInternetString:array[i][@"original_img"]];
        
        model.applicantcn = [self handelInternetString:array[i][@"applicantcn"]];
        
        
        model.tm_name = [self handelInternetString:array[i][@"tm_name"]];
         model.imageShow1 = [self handelInternetString:array[i][@"imageShow1"]];
         model.tmdesigndeclare = [self handelInternetString:array[i][@"tmdesigndeclare"]];
         model.status = [self handelInternetString:array[i][@"status"]];
        
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getHomeModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        HomePageModel *model = [HomePageModel new];
        model.goods_id = [self handelInternetString:array[i][@"goods_id"]];
        
        model.goods_sn = [self handelInternetString:array[i][@"goods_sn"]];
        
        model.goods_name = [self handelInternetString:array[i][@"goods_name"]];
        
        model.shop_price = [self handelInternetString:array[i][@"shop_price"]];
        model.original_img = [self handelInternetString:array[i][@"original_img"]];
        
        model.cat_id = [self handelInternetString:array[i][@"cat_id"]];
        
          model.url = [self handelInternetString:array[i][@"url"]];
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}
+ (NSMutableArray *)getSendOutModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    NSArray *array = responseObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0 ; i < array.count ; i ++) {
        
        SendOutModel *model = [SendOutModel new];
       
        model.tmName = [self handelInternetString:array[i][@"tmName"]];
        NSString *status = [self handelInternetString:array[i][@"currentStatus"]];
        if ([status isEqualToString:@"状态无效"]) {
            model.canUse = NO;
        } else {
            model.canUse = YES;
        }
        
        model.tmImg = [NSString stringWithFormat:@"%@/%@",CSImageBaseURL, [self handelInternetString:array[i][@"tmImg"]]];

         model.intCls = [self handelInternetString:array[i][@"intCls"]];
        

         model.regNo = [self handelInternetString:array[i][@"regNo"]];
        
        model.chooseSelect = NO;
        
        [mutableArray addObject:model];
    }
    
    return mutableArray;
}

+ (SendOutModel *)getSendOutPreciseModelArray:(id)responseObject {
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    
        SendOutModel *model = [SendOutModel new];
        model.agent = [self handelInternetString:responseObject[@"agent"]];
        
        model.announcementDate = [self handelInternetString:responseObject[@"announcementDate"]];
        
        model.announcementIssue = [self handelInternetString:responseObject[@"announcementIssue"]];
        
        model.appDate = [self handelInternetString:responseObject[@"appDate"]];
        model.applicantCn = [self handelInternetString:responseObject[@"applicantCn"]];
        
     
        
        model.goodsCode = [self handelInternetString:responseObject[@"goodsCode"]];
        
        model.intCls = [self handelInternetString:responseObject[@"intCls"]];
        
        model.regDate = [self handelInternetString:responseObject[@"regDate"]];
        
        model.regIssue = [self handelInternetString:responseObject[@"regIssue"]];
        
        model.regNo = [self handelInternetString:responseObject[@"regNo"]];
        model.tmImg =  [self handelInternetString:responseObject[@"tmImg"]];
        model.tmName = [self handelInternetString:responseObject[@"tmName"]];
    
  
    return model;
}

+ (NSString *)handelInternetString:(id)string {
    NSString *newString =  [NSString stringWithFormat:@"%@",string];
    if (csCharacterIsBlank(newString)) {
        newString = @"";
    }
    return newString;
}

@end
