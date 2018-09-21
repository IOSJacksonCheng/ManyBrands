//
//  SuperClassIdTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/19.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SuperClassIdTableViewCell.h"
@interface SuperClassIdTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation SuperClassIdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SuperClassIdModel *)model {
    _model = model;
    if (model.isChooseStatus) {
        self.contentLabel.backgroundColor = csNavigationBarColor;
        self.contentLabel.textColor = csWhiteColor;
    } else {
        self.contentLabel.backgroundColor = csWhiteColor;
        self.contentLabel.textColor = csBlackColor;
    }
    self.contentLabel.text = model.title;
}
@end
