//
//  LoginInViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/8/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "LoginInViewController.h"
#import "RegisterViewController.h"
@interface LoginInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *showCodeButton;
- (IBAction)clickShowCodeButtonDone:(id)sender;

- (IBAction)clickLoginButtonDone:(id)sender;
- (IBAction)clickRegisterButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)clickForgetButtonDone:(id)sender;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self changeButtonStatus];
   
    [self configNavigationBar];
}
- (void)changeButtonStatus {
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, MainScreenWidth - 15 * 2, 45);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"FDA128"] CGColor],(id)[[UIColor colorWithHexString:@"FC491E"] CGColor]]];//渐变数组
    
    [self.loginButton.layer insertSublayer:gradientLayer atIndex:0];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    UIImage *rightImage = [[UIImage imageNamed:@"whiteBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(goBackButtonClickDid)];
    self.navigationItem.leftBarButtonItem = rightItem;
   
    
}
- (void)goBackButtonClickDid {
    [self.view endEditing:YES];
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickShowCodeButtonDone:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        //show code
        self.codeTextField.secureTextEntry = NO;
        
        NSString *str  = self.codeTextField.text;
        
        self.codeTextField.text = @"";
        self.codeTextField.text = str;
        
    } else {
        self.codeTextField.secureTextEntry = YES;
    }
}

- (IBAction)clickLoginButtonDone:(id)sender {
    if (csCharacterIsBlank(self.phoneTextField.text)|| csCharacterIsBlank(self.codeTextField.text)) {
        CustomWrongMessage(@"请输入用户名或密码")
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"username"] = self.phoneTextField.text;
    parameter[@"password"] = self.codeTextField.text;
    [CSNetworkingManager sendPostRequestWithUrl:CSLoginURL Parpmeters:parameter success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            [[NSUserDefaults standardUserDefaults] setValue: [NSString stringWithFormat:@"%@",CSGetResult[@"token"]] forKey:@"CSGetToken"];
           
            [[NSUserDefaults standardUserDefaults] setValue:self.phoneTextField.text forKey:@"CSName"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
        CSInternetFailure
    }];
}

- (IBAction)clickRegisterButtonDone:(id)sender {
    RegisterViewController *new = [RegisterViewController new];
    new.passString = @"注册";
    [self.navigationController pushViewController:new animated:YES];
}
- (IBAction)clickForgetButtonDone:(id)sender {
    RegisterViewController *new = [RegisterViewController new];
    new.passString = @"忘记密码";
    [self.navigationController pushViewController:new animated:YES];
}
@end
