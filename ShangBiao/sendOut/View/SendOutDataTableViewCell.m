//
//  SendOutDataTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/7.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SendOutDataTableViewCell.h"
@interface SendOutDataTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation SendOutDataTableViewCell

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
    if (model.isCanUse) {
        self.selectImageView.hidden = NO;
    } else {
        self.selectImageView.hidden = YES;
    }
    if (model.chooseSelect) {
        self.selectImageView.image = DotaImageName(@"shorcartCell");
    } else {
        self.selectImageView.image = DotaImageName(@"shorcartCell_empty");
    }
    
    self.titleLabel.text =  [NSString stringWithFormat:@"%@(%@)",model.tmName,model.intCls];
}
@end
