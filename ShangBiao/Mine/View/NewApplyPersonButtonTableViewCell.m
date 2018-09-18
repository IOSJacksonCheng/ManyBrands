//
//  NewApplyPersonButtonTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/18.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "NewApplyPersonButtonTableViewCell.h"
@interface NewApplyPersonButtonTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation NewApplyPersonButtonTableViewCell

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
    self.contentLabel.text = model.content;
}
@end
