
//
//  MySendOutBrandTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MySendOutBrandTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface MySendOutBrandTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *changePriceLabel;

@end
@implementation MySendOutBrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.changePriceLabel.layer.cornerRadius = 5;
    self.changePriceLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MySendOutListModel *)model {
    _model = model;
    self.nameLabel.text =  [NSString stringWithFormat:@"%@(%@)",model.goods_name, model.goods_sn];
    self.applyPersonLabel.text =  [NSString stringWithFormat:@"申请人:%@",model.applicantcn];
    self.moneyLabel.text =  [NSString stringWithFormat:@"低价:%@",model.cost_price];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.original_img] placeholderImage:PlaceHolderImage];
}
@end
