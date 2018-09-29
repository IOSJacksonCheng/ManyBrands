//
//  SearchFreeViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/29.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SearchFreeViewController.h"
#import "SearchFreeTableViewCell.h"

@interface SearchFreeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, assign) int page;
@end

@implementation SearchFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    self.page = 1;
    [self configTableView];
}
- (void)sendGetRequestForProgressInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"apply_num"] = self.passNum;
    parameters[@"proposer"] = self.passPerson;
    self.page += 1;
   parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetworkingManager sendGetRequestWithUrl:CSSearchProgressURL parameters:parameters success:^(id responseObject) {
         [self.listTableView.mj_footer endRefreshing];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = @[].mutableCopy;
            array = [CSParseManager getSearchFreeResultListModelArray:CSGetResult];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了")
                
            } else {
                [self.listArray addObjectsFromArray:array];
                [self.listTableView reloadData];
            }
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
        [self.listTableView.mj_footer endRefreshing];
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.rowHeight = 60;
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SearchFreeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SearchFreeTableViewCell)];
    if (self.progressSearch) {
         self.listTableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForProgressInfomation)];
    }
   
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchFreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SearchFreeTableViewCell) forIndexPath:indexPath];
    
    SearchFreeResultModel *model = self.listArray[indexPath.row];
    
    cell.model = model;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = csf1f1f1Color;
    
    NSArray *array = @[@"商标号", @"商标名称", @"申请人", @"商标类别"];
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
