//
//  SearchResultViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/4.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SearchResultViewController.h"
#import "HomePageBrandTableViewCell.h"
@interface SearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@property (weak, nonatomic) IBOutlet UITableView *resultTbaleView;


@end

@implementation SearchResultViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    [self configTableView];
    [self sendGetRequestForNewInfomation];
}

- (void)sendGetRequestForNewInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    self.page = 1;
    
    parameters[@"keyword"] = self.recordKeyWord;
    parameters[@"cat_id"] = self.recordClassId;
    parameters[@"type"] = self.recordType;
    parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    //leibie
    

    
    [CSNetworkingManager sendGetRequestWithUrl:CSProductListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            
            self.dataArray = [CSParseManager getHomeModelArray:CSGetResult];
            [self.resultTbaleView reloadData];
        } else {
            CSShowWrongMessage
        }
        [self tableViewEndRefresh];
        
    } failure:^(NSError *error) {
        [self tableViewEndRefresh];
        
        CSInternetFailure
    }];
}
- (void)tableViewEndRefresh {
    if (self.resultTbaleView.mj_header.isRefreshing) {
        [self.resultTbaleView.mj_header endRefreshing];
    }
    if (self.resultTbaleView.mj_footer.isRefreshing) {
        [self.resultTbaleView.mj_footer endRefreshing];
    }
}
- (void)sendGetRequestForMoreInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.page ++;
    
    parameters[@"keyword"] = self.recordKeyWord;
    parameters[@"cat_id"] = self.recordClassId;
    parameters[@"type"] = self.recordType;
    parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    [CSNetworkingManager sendGetRequestWithUrl:CSProductListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getHomeModelArray:CSGetResult];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
                [self.dataArray addObjectsFromArray:array];
                [self.resultTbaleView reloadData];
            }
            
            
        } else {
            CSShowWrongMessage
            self.page --;
        }
        [self tableViewEndRefresh];
        
    } failure:^(NSError *error) {
        [self tableViewEndRefresh];
        self.page --;
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.resultTbaleView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.resultTbaleView.rowHeight = ProductCellHeight;
    self.resultTbaleView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForNewInfomation)];
     self.resultTbaleView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForMoreInfomation)];
    self.resultTbaleView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self.resultTbaleView registerNib:[UINib nibWithNibName:CSCellName(HomePageBrandTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(HomePageBrandTableViewCell)];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count / 2 == 0) {
        return self.dataArray.count / 2;
    }
    return self.dataArray.count / 2 + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(HomePageBrandTableViewCell) forIndexPath:indexPath];
    if (indexPath.row * 2 < self.dataArray.count) {
        HomePageModel *leftModel = self.dataArray[indexPath.row * 2];
        cell.leftModel = leftModel;
        
    }
    
    
    
    if (indexPath.row * 2 + 1 < self.dataArray.count) {
        HomePageModel *rightModel = self.dataArray[indexPath.row* 2 + 1];
        cell.rightModel = rightModel;
    }
    
    
    return cell;;
}

@end
