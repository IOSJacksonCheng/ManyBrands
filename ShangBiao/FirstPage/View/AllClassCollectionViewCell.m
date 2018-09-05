//
//  AllClassCollectionViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/5.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "AllClassCollectionViewCell.h"

@implementation AllClassCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.classNameLabel.layer.borderWidth = 1;
    self.classNameLabel.layer.borderColor = csNavigationBarColor.CGColor;
    self.classNameLabel.layer.cornerRadius = 10;
}

@end
