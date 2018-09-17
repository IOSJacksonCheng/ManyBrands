//
//  SendOutTableViewCell.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/6.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendOutModel.h"
@interface SendOutTableViewCell : UITableViewCell
@property (nonatomic, strong) SendOutModel *model;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@end
