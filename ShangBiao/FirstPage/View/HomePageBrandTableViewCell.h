//
//  HomePageBrandTableViewCell.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
@interface HomePageBrandTableViewCell : UITableViewCell
@property (nonatomic, strong) HomePageModel *leftModel;
@property (nonatomic, strong) HomePageModel *rightModel;
@end
