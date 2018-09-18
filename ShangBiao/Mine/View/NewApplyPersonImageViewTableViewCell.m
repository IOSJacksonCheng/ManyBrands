//
//  NewApplyPersonImageViewTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/18.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "NewApplyPersonImageViewTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface NewApplyPersonImageViewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;


@end
@implementation NewApplyPersonImageViewTableViewCell

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
    self.remarkLabel.text = model.remark;
    if (!csCharacterIsBlank(model.content)) {
        
        self.contentImageView.image = model.chooseImage;
        
    }
}
@end
