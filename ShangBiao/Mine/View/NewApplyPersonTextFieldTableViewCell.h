//
//  NewApplyPersonTextFieldTableViewCell.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/18.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewApplyPersonModel.h"
@interface NewApplyPersonTextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (nonatomic, strong) NewApplyPersonModel *model;
@end
