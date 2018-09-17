//
//  MySendoutRegisterTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MySendoutRegisterTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface MySendoutRegisterTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
@implementation MySendoutRegisterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MySendOutListModel *)model {
    _model = model;
    self.nameLabel.text =  model.tm_name;
    self.explainLabel.text = model.tmdesigndeclare;
    self.statusLabel.text =  model.status;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.imageShow1] placeholderImage:PlaceHolderImage];
    
}

@end
