//
//  TwoKindsSendOutViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "TwoKindsSendOutViewController.h"
#import "SendOutBrandViewController.h"
@interface TwoKindsSendOutViewController ()
@property (weak, nonatomic) IBOutlet UIView *registerNumView;
@property (weak, nonatomic) IBOutlet UIView *registerPersonView;

@end

@implementation TwoKindsSendOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title =@"发布";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPersonView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.registerPersonView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNumView)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    [self.registerNumView addGestureRecognizer:tap1];
}
- (void)clickPersonView {
    SendOutBrandViewController *new = [SendOutBrandViewController new];
    new.type = @"0";
    [self.navigationController pushViewController:new animated:YES];
}
- (void)clickNumView {
    SendOutBrandViewController *new = [SendOutBrandViewController new];
       new.type = @"1";
    [self.navigationController pushViewController:new animated:YES];
}

@end
