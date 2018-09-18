//
//  NewApplyPersonTextFieldTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/18.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "NewApplyPersonTextFieldTableViewCell.h"
@interface NewApplyPersonTextFieldTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation NewApplyPersonTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(NewApplyPersonModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.contentTextField.placeholder = model.placeHolder;
    self.contentTextField.text = model.content;
}
@end
