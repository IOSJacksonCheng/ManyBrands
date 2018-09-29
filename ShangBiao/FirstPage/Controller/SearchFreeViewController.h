//
//  SearchFreeViewController.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/29.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchFreeViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSString *passNum;
@property (nonatomic, strong) NSString *passPerson;
@property (nonatomic, assign) BOOL progressSearch;
@end

NS_ASSUME_NONNULL_END
