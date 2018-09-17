//
//  RegisterBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterBrandViewController.h"
#import "RegisterFirstStepViewController.h"
@interface RegisterBrandViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (IBAction)clickRegisterButtonDone:(UIButton *)sender;

@end

@implementation RegisterBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.contentLabel.text = @"1、商标查询存在盲期，从商标局接受注册申请到录入数据库，其中有3-4个月的延迟期。\n\n2、在查询盲期内，可能会存在已有相同或类似的商标提交。\n\n3、商标总局对申请商标采用在先原则和近似原则的审核方式";
}




- (IBAction)clickRegisterButtonDone:(UIButton *)sender {
    if (csCharacterIsBlank(CSGetToken)) {
        [CSUtility showLoginViewController];
        return;
    }
    RegisterFirstStepViewController *new = [RegisterFirstStepViewController new];
    [self.navigationController pushViewController:new animated:YES];
   
}
@end
