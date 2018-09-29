//
//  SearchFreeTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/29.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SearchFreeTableViewCell.h"
#import "SearchFreeResultModel.h"
@interface SearchFreeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;

@end
@implementation SearchFreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SearchFreeResultModel *)model {
    _model = model;
    self.firstLabel.text = model.regNo;
    self.secondLabel.text = model.tmName;
    self.thirdLabel.text = model.applicantCn;
    self.fourthLabel.text = model.intCls;
}
@end
