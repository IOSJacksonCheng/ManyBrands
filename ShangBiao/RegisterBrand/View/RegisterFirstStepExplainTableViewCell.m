//
//  RegisterFirstStepExplainTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterFirstStepExplainTableViewCell.h"

@implementation RegisterFirstStepExplainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.explainLabel.text = @"中文商标请描述字体名称，图形商标请描述设计要素，英文商标请描述中文含义，非必填";
    self.explainTextView.layer.cornerRadius = 5;
    self.explainTextView.layer.borderColor = csf1f1f1Color.CGColor;
    self.explainTextView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
