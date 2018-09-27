
//
//  MakeDealViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MakeDealViewController.h"
#import "HomePageBrandTableViewCell.h"
#import "AllClassTypeViewController.h"
@interface MakeDealViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *makeDealTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *recordCheckType;
@property (nonatomic, strong) NSString *recordOrder;
@property (nonatomic, strong) NSString *recordType;


@property (nonatomic, assign) int page;

@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextfield;
- (IBAction)clickTopViewButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation MakeDealViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易";
    self.recordCheckType = @"price";
    self.recordOrder = @"2";
    [self configSubViews];
    [self clickPriceButton];
    [self configTableView];
    [self sendGetRequestForNewInfomation];
}
- (void)configSubViews {
    self.keywordTextfield.text = self.recordKeyword;
    self.buttonView.layer.cornerRadius = 5;
    self.buttonView.layer.masksToBounds = YES;
}
- (void)sendGetRequestForNewInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    self.page = 1;
    
    parameters[@"keyword"] = self.keywordTextfield.text;
    parameters[@"type"] = self.recordType;
    parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    parameters[@"cat_id"] = self.recordClassId;
    //leibie
    parameters[@"o"] = self.recordCheckType;
    //paixu
    parameters[@"t"] = self.recordOrder;
    [CSNetworkingManager sendGetRequestWithUrl:CSProductListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            
            self.dataArray = [CSParseManager getHomeModelArray:CSGetResult];
            [self.makeDealTableView reloadData];
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
    if (self.makeDealTableView.mj_header.isRefreshing) {
        [self.makeDealTableView.mj_header endRefreshing];
    }
    if (self.makeDealTableView.mj_footer.isRefreshing) {
        [self.makeDealTableView.mj_footer endRefreshing];
    }
}
- (void)sendGetRequestForMoreInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    self.page ++;
    
    parameters[@"keyword"] = self.keywordTextfield.text;
    parameters[@"type"] = self.recordType;
    parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    //leibie
    parameters[@"o"] = self.recordCheckType;
    //paixu
    parameters[@"t"] = self.recordOrder;
    [CSNetworkingManager sendGetRequestWithUrl:CSProductListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getHomeModelArray:CSGetResult];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
                [self.dataArray addObjectsFromArray:array];
                [self.makeDealTableView reloadData];
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
    self.makeDealTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.makeDealTableView.rowHeight = ProductCellHeight;
    self.makeDealTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForNewInfomation)];
    self.makeDealTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForMoreInfomation)];
    self.makeDealTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
  
    [self.makeDealTableView registerNib:[UINib nibWithNibName:CSCellName(HomePageBrandTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(HomePageBrandTableViewCell)];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count % 2 == 0) {
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

- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    
    
    if (sender.tag == 0) {
        //0 typeButton
        
        AllClassTypeViewController *new = [AllClassTypeViewController new];
        [self.navigationController pushViewController:new animated:YES];
            //0商标名  1注册号  2 持有人
            //1.创建AlertController
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//            NSArray *messageArray = @[@"商标名", @"注册号", @"持有人"];
//
//            for (int i = 0; i < messageArray.count; i++) {
//
//                UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                    dispatch_async(dispatch_get_main_queue(), ^{
//
//                        [self.typeButton setTitle:messageArray[i] forState:UIControlStateNormal];
//
//                        self.recordType =  [NSString stringWithFormat:@"%d",i];
//                    });
//
//                }];
//
//                [alert addAction:action];
//
//            }
//
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//
//
//            }];
//            //3.将按钮添加到AlertController中
//
//            [alert addAction:cancelAction];
//
//            //5.显示AlertController
//            [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
        
        
    } else if (sender.tag == 1) {
        //Search
        [self sendGetRequestForNewInfomation];
    } else if (sender.tag == 2) {
        //price
        [self clickPriceButton];
        //排序类型 price 价格  create_time 时间
        self.recordCheckType = @"price";
        self.priceButton.selected = !self.priceButton.selected;
       //1降序  2 升序
        if (self.priceButton.selected) {
            self.recordOrder = @"1";
        } else {
            self.recordOrder = @"2";
        }
        [self sendGetRequestForNewInfomation];
    } else if (sender.tag == 3) {
        //time
        [self clickTimeButton];
        //排序类型 price 价格  create_time 时间
        self.recordCheckType = @"create_time";
        self.timeButton.selected = !self.timeButton.selected;
        //1降序  2 升序
        if (self.timeButton.selected) {
            self.recordOrder = @"1";
        } else {
            self.recordOrder = @"2";
        }
        [self sendGetRequestForNewInfomation];
    }
}
- (void)clickTimeButton {
    self.priceButton.layer.borderColor = csf1f1f1Color.CGColor;
    self.priceButton.layer.borderWidth = 1;
    self.priceButton.layer.cornerRadius = 5;
    
    self.timeButton.layer.borderColor = csNavigationBarColor.CGColor;
    self.timeButton.layer.borderWidth = 1;
    self.timeButton.layer.cornerRadius = 5;
}
- (void)clickPriceButton {
    self.priceButton.layer.borderColor = csNavigationBarColor.CGColor;
    self.priceButton.layer.borderWidth = 1;
    self.priceButton.layer.cornerRadius = 5;
    
    self.timeButton.layer.borderColor = csf1f1f1Color.CGColor;
    self.timeButton.layer.borderWidth = 1;
    self.timeButton.layer.cornerRadius = 5;
}
@end
