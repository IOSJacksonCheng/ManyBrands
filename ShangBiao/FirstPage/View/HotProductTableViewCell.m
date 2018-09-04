//
//  HotProductTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HotProductTableViewCell.h"
#import "SearchResultViewController.h"
@interface HotProductTableViewCell()

@end
@implementation HotProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)handleClickViewWithClassId:(NSString *)goodsId {
    SearchResultViewController *new = [SearchResultViewController new];
    
    new.recordClassId = goodsId;
    
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
@end
