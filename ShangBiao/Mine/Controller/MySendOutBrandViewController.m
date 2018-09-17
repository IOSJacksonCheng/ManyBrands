//
//  MySendOutBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MySendOutBrandViewController.h"
#import "MySendOutBrandTableViewCell.h"
@interface MySendOutBrandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation MySendOutBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发布";
    [self configTableView];
    [self sendGetRequestForListInfo];
}
- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.rowHeight = 100;
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(MySendOutBrandTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MySendOutBrandTableViewCell)];
}
- (void)sendGetRequestForListInfo {
    [CSNetworkingManager sendGetRequestWithUrl:CSMySendOutListURL parameters:nil success:^(id responseObject) {
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
    MySendOutBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MySendOutBrandTableViewCell) forIndexPath:indexPath];
    MySendOutListModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
@end
