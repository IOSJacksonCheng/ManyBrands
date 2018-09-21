//
//  RegisterSecondStepCollectionViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/19.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterSecondStepCollectionViewCell.h"
@interface RegisterSecondStepCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation RegisterSecondStepCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(CategoryClassIdModel *)model {
    self.titleLabel.text = model.title;
    if (model.isChooseStatus) {
        self.layer.borderColor = csNavigationBarColor.CGColor;
        self.layer.borderWidth = 1;
    } else {
        self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        self.layer.borderWidth = 1;
    }
}
@end
