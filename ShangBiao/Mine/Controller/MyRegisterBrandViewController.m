//
//  MyRegisterBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MyRegisterBrandViewController.h"
#import "MySendoutRegisterTableViewCell.h"
@interface MyRegisterBrandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation MyRegisterBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的注册";
    [self configTableView];
    [self sendGetRequestForListInfo];
}
- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.rowHeight = 100;
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(MySendoutRegisterTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MySendoutRegisterTableViewCell)];
}
- (void)sendGetRequestForListInfo {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
   
    [CSNetworkingManager sendGetRequestWithUrl:CSMySendOutRegisterListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getMySendOutListModelArray:CSGetResult];
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
    MySendoutRegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MySendoutRegisterTableViewCell) forIndexPath:indexPath];
    MySendOutListModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = csf1f1f1Color;
    
    NSArray *array = @[@"商标名称", @"商标图样", @"商标说明", @"状态"];
    CGFloat labelWidth = self.view.width / 4;
    
    for (int i = 0; i < array.count; i ++) {
        UILabel *lable = [self getTitleLabel:array[i]];
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo( i * labelWidth);
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
@end
