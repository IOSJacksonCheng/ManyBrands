//
//  SendOutTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/6.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SendOutTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface SendOutTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *registerNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@end
@implementation SendOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SendOutModel *)model {
    self.registerNumLabel.text = model.regNo;
    self.priceTextField.text = model.willBuyTextField;
    self.brandNameLabel.text = model.tmName;
    self.classLabel.text = model.intCls;
    [self.brandImageView sd_setImageWithURL:[NSURL URLWithString:model.tmImg] placeholderImage:PlaceHolderImage];
}
@end
