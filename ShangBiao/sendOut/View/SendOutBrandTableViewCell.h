//
//  SendOutBrandTableViewCell.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendOutModel.h"
@interface SendOutBrandTableViewCell : UITableViewCell
@property (nonatomic, strong) SendOutModel *model;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@end
