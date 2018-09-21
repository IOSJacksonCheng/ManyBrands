//
//  CategoryClassIdModel.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/19.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryClassIdModel : NSObject
@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSMutableArray *item;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, getter=isChooseStatus) BOOL chooseStatus;

@property (nonatomic, strong) NSString *grandFatherTitle;
@property (nonatomic, strong) NSString *fatherTitle;
@property (nonatomic, assign) BOOL firstRow;
@end
