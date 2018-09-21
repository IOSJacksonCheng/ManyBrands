//
//  MySendOutBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "MySendOutBrandViewController.h"
#import "MySendOutBrandTableViewCell.h"
@interface MySendOutBrandViewController ()<UITableViewDelegate, UITableViewDataSource>
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [CSNetworkingManager sendGetRequestWithUrl:CSMySendOutListURL parameters:parameters success:^(id responseObject) {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        //提示框添加文本输入框

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改价格" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for(UITextField *text in alert.textFields){
            MySendOutListModel *model = self.listArray[indexPath.row];
            [self sendPostChangePriceWithText:text.text WithId:model.goods_id];
        }

    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"填写要修改的价格";
            textField.keyboardType = UIKeyboardTypeDecimalPad;
        }];
    
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
   
    

   
}
- (void)sendPostChangePriceWithText:(NSString *)price WithId:(NSString *)idString {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"goods_id"] = idString;
    parameters[@"cost_price"] = price;
    [CSNetworkingManager sendPostRequestWithUrl:CSChangePriceURL Parpmeters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"修改成功");
            [self sendGetRequestForListInfo];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
        CSInternetFailure
    }];
}
@end
