//
//  HomePageBrandTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HomePageBrandTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductDetailViewController.h"
@interface HomePageBrandTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightClassLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@end
@implementation HomePageBrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftView)];
    leftTap.numberOfTapsRequired = 1;
    leftTap.numberOfTouchesRequired = 1;
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightView)];
    rightTap.numberOfTouchesRequired = 1;
    rightTap.numberOfTapsRequired = 1;
    [self.leftView addGestureRecognizer:leftTap];
    [self.rightView addGestureRecognizer:rightTap];
}
- (void)clickLeftView {
    ProductDetailViewController *new = [ProductDetailViewController new];
    new.model = self.leftModel;
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
- (void)clickRightView {
    if (csCharacterIsBlank(self.rightModel.goods_id)) {
        return;
    }
    ProductDetailViewController *new = [ProductDetailViewController new];
     new.model = self.rightModel;
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
- (void)setLeftModel:(HomePageModel *)leftModel {
    _leftModel = leftModel;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.original_img] placeholderImage:PlaceHolderImage];
    self.nameLabel.text = leftModel.goods_name;
    self.classLabel.text =  [NSString stringWithFormat:@"第%@类/",leftModel.cat_id];
    self.moneyLabel.text = leftModel.shop_price;
}
- (void)setRightModel:(HomePageModel *)rightModel {
    _rightModel = rightModel;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.original_img] placeholderImage:PlaceHolderImage];
    self.rightNameLabel.text = rightModel.goods_name;
    self.rightClassLabel.text =  [NSString stringWithFormat:@"第%@类/",rightModel.cat_id];
    self.rightMoneyLabel.text = rightModel.shop_price;
}
@end
