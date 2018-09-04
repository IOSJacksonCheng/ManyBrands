//
//  HomePageTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "SearchResultViewController.h"
@interface HomePageTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *fabuView;
@property (weak, nonatomic) IBOutlet UIView *zhuceView;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIView *chaxunView;
@property (weak, nonatomic) IBOutlet UIView *jiaoyiView;
- (IBAction)clickTypeButtonDone:(UIButton *)sender;
- (IBAction)clickSearchButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *keyWrodTextField;
@property (nonatomic, strong) NSString *recordType;
@end
@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.fabuView.layer.cornerRadius = 30;
    self.fabuView.layer.masksToBounds = YES;
    
    self.zhuceView.layer.cornerRadius = 30;
    self.zhuceView.layer.masksToBounds = YES;
    
    self.chaxunView.layer.cornerRadius = 30;
    self.chaxunView.layer.masksToBounds = YES;
    
    self.jiaoyiView.layer.cornerRadius = 30;
    self.jiaoyiView.layer.masksToBounds = YES;
}

- (IBAction)clickTypeButtonDone:(UIButton *)sender {
    //0商标名  1注册号  2 持有人
    //1.创建AlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  
    NSArray *messageArray = @[@"商标名", @"注册号", @"持有人"];
    
    for (int i = 0; i < messageArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.typeButton setTitle:messageArray[i] forState:UIControlStateNormal];
                self.recordType =  [NSString stringWithFormat:@"%d",i];
            });
            
        }];
        
        [alert addAction:action];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
      
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}

- (IBAction)clickSearchButtonDone:(UIButton *)sender {
    
    SearchResultViewController *new = [SearchResultViewController new];
    new.recordKeyWord = self.keyWrodTextField.text;
    new.recordType = self.recordType;
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
@end
