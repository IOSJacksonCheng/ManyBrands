//
//  CSParseManager.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSParseManager.h"

#import "HomePageModel.h"

@implementation CSParseManager
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
+ (NSString *)handelInternetString:(id)string {
    NSString *newString =  [NSString stringWithFormat:@"%@",string];
    if (csCharacterIsBlank(newString)) {
        newString = @"";
    }
    return newString;
}
@end
