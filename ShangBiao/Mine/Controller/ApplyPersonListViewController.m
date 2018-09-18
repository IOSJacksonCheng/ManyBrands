//
//  ApplyPersonListViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "ApplyPersonListViewController.h"
#import "ApplyPersonListTableViewCell.h"
#import "NewApplyPersonViewController.h"
@interface ApplyPersonListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *listArray;
- (IBAction)clickAddNewContactButtonDone:(id)sender;
@end

@implementation ApplyPersonListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendGetRequestForListInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请列表";
    [self configTableView];
    [self sendGetRequestForListInfo];
}
- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.rowHeight = 50;
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ApplyPersonListTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ApplyPersonListTableViewCell)];
}
- (void)sendGetRequestForListInfo {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [CSNetworkingManager sendGetRequestWithUrl:CSApplyPersonListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getApplyPersonListModelArray:CSGetResult];
            [self.listTableView reloadData];
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
        CSInternetFailure
    }];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyPersonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ApplyPersonListTableViewCell) forIndexPath:indexPath];
    ApplyPersonListModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.fromRegister) {
       ApplyPersonListModel *model = self.listArray[indexPath.row];
            if(self.onGetResult)
            {
                self.onGetResult(model.personId,model.templatename);
            }
            [self.navigationController popViewControllerAnimated:YES];
        
       
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = csf1f1f1Color;
    
    NSArray *array = @[@"申请人", @"联系人", @"联系人电话"];
    CGFloat labelWidth = 100;
    
    for (int i = 0; i < array.count; i ++) {
        UILabel *lable = [self getTitleLabel:array[i]];
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(15);
            } else if (i == 2) {
                 make.right.mas_equalTo(-15);
            } else {
                make.centerX.mas_equalTo(0);
            }
         
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(labelWidth);
        }];
    }
    return view;
}
- (UILabel *)getTitleLabel:(NSString *)title {
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = csBlackColor;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (IBAction)clickAddNewContactButtonDone:(id)sender {
    NewApplyPersonViewController *new = [NewApplyPersonViewController new];
    [self.navigationController pushViewController:new animated:YES];
}

@end
