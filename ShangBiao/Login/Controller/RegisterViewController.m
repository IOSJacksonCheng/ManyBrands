//
//  RegisterViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *againCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
- (IBAction)clickSendSecurityButtonDone:(id)sender;
- (IBAction)clickRegisterButtonDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendSecurityButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.passString;
    [self changeButtonStatus];
}
- (void)changeButtonStatus {
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 150, 40);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"FDA128"] CGColor],(id)[[UIColor colorWithHexString:@"FC491E"] CGColor]]];//渐变数组
    
    [self.sendSecurityButton.layer insertSublayer:gradientLayer atIndex:0];
    self.sendSecurityButton.layer.cornerRadius = 5;
    self.sendSecurityButton.layer.masksToBounds = YES;
}
//发送验证码显示按钮时间
- (void)startTime {
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendSecurityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendSecurityButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            if (timeout == 60) {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.sendSecurityButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.sendSecurityButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)clickSendSecurityButtonDone:(id)sender {
    [self.view endEditing:YES];
    if(csCharacterIsBlank(self.phoneTextField.text))
    {
        
        CustomWrongMessage(@"请输入手机号码")
    }
    else
    {
        
        [self doGetCodeWithUserName:self.phoneTextField.text];
    }
}
- (void)doGetCodeWithUserName:(NSString *)userName {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"mobile"] = self.phoneTextField.text;
    
    [CSNetworkingManager sendGetRequestWithUrl:CSGetCodeURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"验证码已经发送")
            
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
       CSInternetFailure
    }];
}
- (IBAction)clickRegisterButtonDone:(id)sender {
    
    NSString *phone = self.phoneTextField.text;
    NSString *code = self.codeTextField.text;
    NSString *againCode = self.againCodeTextField.text;
    NSString *security = self.securityCodeTextField.text;
    
    
    if (csCharacterIsBlank(phone)||csCharacterIsBlank(code) || csCharacterIsBlank(againCode) || csCharacterIsBlank(security)) {
        CustomWrongMessage(@"请输入完整信息")
        return;
    }
    if (![code isEqualToString:againCode]) {
        CustomWrongMessage(@"两次密码输入不一致")
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = phone;
    parameters[@"password"] = code;
    parameters[@"password2"] = againCode; parameters[@"mobile_code"] = security;
    NSString *url = nil;
    if ([self.passString isEqualToString:@"注册"]) {
        url = CSRegisterURL;
    } else {
        url = CSForgetCodeAndChangeCodeURL;
    }
    [CSNetworkingManager sendPostRequestWithUrl:url Parpmeters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            if ([self.passString isEqualToString:@"注册"]) {
                CustomWrongMessage(@"注册成功");
            }else {
                CustomWrongMessage(@"修改密码成功");
            }
            
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
       CSInternetFailure
    }];
}
@end
