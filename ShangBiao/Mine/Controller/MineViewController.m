//
//  MineViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)clickButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameLabel.text = CSName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = csf1f1f1Color.CGColor;
   
    self.searchButton.layer.cornerRadius = 5;
      self.nameLabel.text = CSName;
}


- (IBAction)clickButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        //fabu
        
    } else if (sender.tag == 1) {
        //gouwuche
        
    } else if (sender.tag == 2) {
        //chaxun
        
    }
}
@end
