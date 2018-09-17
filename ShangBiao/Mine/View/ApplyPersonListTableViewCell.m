//
//  ApplyPersonListTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "ApplyPersonListTableViewCell.h"
@interface ApplyPersonListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *applyPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end
@implementation ApplyPersonListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ApplyPersonListModel *)model {
    _model = model;
    self.applyPersonLabel.text = model.templatename;
    self.contactPersonLabel.text = model.receive_name;
    self.phoneLabel.text = model.receive_phone;
}
@end
