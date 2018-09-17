//
//  MineViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MySendOutBrandViewController.h"
#import "MyRegisterBrandViewController.h"
#import "ApplyPersonListViewController.h"
@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)clickButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *mineTableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameLabel.text = CSName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configSubViews];
}
- (void)configSubViews {
    self.title = @"我的";
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = csf1f1f1Color.CGColor;
    
    self.searchButton.layer.cornerRadius = 5;
    self.nameLabel.text = CSName;
    [self.mineTableView registerNib:[UINib nibWithNibName:CSCellName(MineTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MineTableViewCell)];
    self.mineTableView.backgroundColor = csf1f1f1Color;
    self.mineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImageView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:tap];
}
- (void)clickHeadImageView {
    [CSUtility showLoginViewController];
}
- (IBAction)clickButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        //fabu
        MySendOutBrandViewController *new = [MySendOutBrandViewController new];
        [self.navigationController pushViewController:new animated:YES];
    } else if (sender.tag == 1) {
        //gouwuche
        MyRegisterBrandViewController *new = [MyRegisterBrandViewController new];
        [self.navigationController pushViewController:new animated:YES];
    }
}
#pragma mark -- UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MineTableViewCell) forIndexPath:indexPath];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    ApplyPersonListViewController *new = [ApplyPersonListViewController new];
    [self.navigationController pushViewController:new animated:YES];
}
@end
