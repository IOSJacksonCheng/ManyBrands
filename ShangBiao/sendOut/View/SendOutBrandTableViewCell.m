
//
//  SendOutBrandTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SendOutBrandTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface SendOutBrandTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *registerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLael;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
@implementation SendOutBrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SendOutModel *)model {
    _model = model;
   
    if (model.willSendOut) {
        self.selectImageView.image = DotaImageName(@"shorcartCell");
    } else {
        self.selectImageView.image = DotaImageName(@"shorcartCell_empty");
    }
    self.registerNumberLabel.text = model.regNo;
    self.moneyTextField.text = model.willBuyTextField;
    self.nameLael.text = model.tmName;
    self.classLabel.text = model.intCls;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.tmImg] placeholderImage:PlaceHolderImage];
    
    
}
@end
