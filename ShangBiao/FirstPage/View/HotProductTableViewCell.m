//
//  HotProductTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HotProductTableViewCell.h"
#import "MakeDealViewController.h"
@interface HotProductTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *cultureView;
@property (weak, nonatomic) IBOutlet UIView *shoushiView;
@property (weak, nonatomic) IBOutlet UIView *huazhuangpinView;
@property (weak, nonatomic) IBOutlet UIView *guanggaoView;
@property (weak, nonatomic) IBOutlet UIView *fuzhaungView;
@property (weak, nonatomic) IBOutlet UIView *xiangbaoView;

@end
@implementation HotProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
   
    self.cultureView.tag = 21;
    [self.cultureView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap1.numberOfTouchesRequired = 1;
    tap1.numberOfTapsRequired = 1;
    self.shoushiView.tag = 23;
        [self.shoushiView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap2.numberOfTouchesRequired = 1;
    tap2.numberOfTapsRequired = 1;
    self.huazhuangpinView.tag = 22;
        [self.huazhuangpinView addGestureRecognizer:tap2];
    
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap3.numberOfTouchesRequired = 1;
    tap3.numberOfTapsRequired = 1;
    self.guanggaoView.tag = 6;
        [self.guanggaoView addGestureRecognizer:tap3];
    
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap4.numberOfTouchesRequired = 1;
    tap4.numberOfTapsRequired = 1;
    self.fuzhaungView.tag = 4;
        [self.fuzhaungView addGestureRecognizer:tap4];
    
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClassView:)];
    tap5.numberOfTouchesRequired = 1;
    tap5.numberOfTapsRequired = 1;
    self.xiangbaoView.tag = 1;
        [self.xiangbaoView addGestureRecognizer:tap5];
    
    
       
}
- (void)clickClassView:(UITapGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    [self handleClickViewWithClassId: [NSString stringWithFormat:@"%ld",(long)view.tag]];
}
- (void)handleClickViewWithClassId:(NSString *)goodsId {
    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MakeDealViewController *new= [sb instantiateViewControllerWithIdentifier:CSCellName(MakeDealViewController)];
    
    new.recordClassId = goodsId;
    
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
@end
