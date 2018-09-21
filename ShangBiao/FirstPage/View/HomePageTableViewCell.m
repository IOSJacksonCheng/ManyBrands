//
//  HomePageTableViewCell.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "MakeDealViewController.h"
#import "SystemSearchViewController.h"
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
    
    UITapGestureRecognizer *fabuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFabuView)];
    fabuTap.numberOfTapsRequired = 1;
    fabuTap.numberOfTouchesRequired = 1;
    
    [self.fabuView addGestureRecognizer:fabuTap];
    
    UITapGestureRecognizer *zhuceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickZhuceView)];
    zhuceTap.numberOfTapsRequired = 1;
    zhuceTap.numberOfTouchesRequired = 1;
    
    [self.zhuceView addGestureRecognizer:zhuceTap];
    
    UITapGestureRecognizer *chaxunTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChaxunView)];
    chaxunTap.numberOfTapsRequired = 1;
    chaxunTap.numberOfTouchesRequired = 1;
    
    [self.chaxunView addGestureRecognizer:chaxunTap];
    
    
    UITapGestureRecognizer *jiaoyiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJiaoyiView)];
    jiaoyiTap.numberOfTapsRequired = 1;
    jiaoyiTap.numberOfTouchesRequired = 1;
    
    [self.jiaoyiView addGestureRecognizer:jiaoyiTap];
    
    
    
}
- (void)clickJiaoyiView {
      [[CSUtility getCurrentViewController].tabBarController setSelectedIndex:1];
}
- (void)clickChaxunView {
    SystemSearchViewController *new = [SystemSearchViewController new];
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
- (void)clickZhuceView {
      [[CSUtility getCurrentViewController].tabBarController setSelectedIndex:3];
}
- (void)clickFabuView {
    [[CSUtility getCurrentViewController].tabBarController setSelectedIndex:2];
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
    
    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MakeDealViewController *new= [sb instantiateViewControllerWithIdentifier:CSCellName(MakeDealViewController)];
   
    new.recordKeyword = self.keyWrodTextField.text;
    
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
@end
