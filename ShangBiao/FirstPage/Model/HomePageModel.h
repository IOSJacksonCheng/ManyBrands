//
//  HomePageModel.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject
/** 产品ID */
@property (nonatomic, strong) NSString *goods_id;
/** 产品编号 */
@property (nonatomic, strong) NSString *goods_sn;
/** 产品名称 */
@property (nonatomic, strong) NSString *goods_name;
/** 产品价格 */
@property (nonatomic, strong) NSString *shop_price;
/** 产品主图 */
@property (nonatomic, strong) NSString *original_img;
/** 分类ID */
@property (nonatomic, strong) NSString *cat_id;
/** 广告URL */
@property (nonatomic, strong) NSString *url;
@end
