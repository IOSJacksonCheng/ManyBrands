//
//  SendOutViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SendOutViewController.h"

#import "SendOutTableViewCell.h"
#import "SendOutDataTableViewCell.h"
@interface SendOutViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)clickFunctionButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *searchEffectView;
- (IBAction)clickCancelSearchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *internetTableVIew;

- (IBAction)clickSendOutButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *internetArray;
@property (nonatomic, assign) int page;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *QQTextField;
- (IBAction)clickSureSendOutButtonDone:(id)sender;

@end

@implementation SendOutViewController
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[].mutableCopy;
    }
    return _listArray;
}
- (NSMutableArray *)internetArray {
    if (!_internetArray) {
        _internetArray = @[].mutableCopy;
    }
    return _internetArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"商标发布";
    self.buttonView.layer.cornerRadius = 5;
    self.buttonView.layer.borderColor = csf1f1f1Color.CGColor;
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.masksToBounds = YES;
    [self clickBrandButton];
    [self configTableView];
    
}
- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SendOutTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SendOutTableViewCell)];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.listTableView.rowHeight = 55;
    [self.internetTableVIew registerNib:[UINib nibWithNibName:CSCellName(SendOutDataTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SendOutDataTableViewCell)];
    self.internetTableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    self.internetTableVIew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForInfomation)];
 
    self.internetTableVIew.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForMoreFuzzySearchInfomation)];
    self.internetTableVIew.rowHeight = 60;
    self.internetTableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)clickBrandButton {
    self.brandButton.selected = YES;
    [self.brandButton setBackgroundColor:csNavigationBarColor];
     [self.brandButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    
    [self.applyButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    [self.applyButton setBackgroundColor:csWhiteColor];
    self.applyButton.selected = NO;
    self.titleLabel.text = @"商标注册号";
}
- (void)clickApplyButton {
    self.applyButton.selected = YES;
    [self.applyButton setBackgroundColor:csNavigationBarColor];
  [self.applyButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    
    
    [self.brandButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    [self.brandButton setBackgroundColor:csWhiteColor];
    self.brandButton.selected = NO;
     self.titleLabel.text = @"商标申请人";
       
}

- (IBAction)clickFunctionButtonDone:(UIButton *)sender {
    //0 brand
    if (sender.tag == 0) {
        [self clickBrandButton];
    } else if (sender.tag == 1) {
         //1 person
        [self clickApplyButton];
    } else if (sender.tag == 2) {
        
        //2 search
        [self.view endEditing:YES];
        if (self.brandButton.selected) {
            [self sendGetRequestForPreciseSearch];
        } else {
            [self sendGetRequestForFuzzySearch];
        }
        
    }
   
    

}
- (void)sendGetRequestForPreciseSearch {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"keyword"] = self.keywordTextField.text;
    
    parameters[@"type"] = @"1";
    

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    UIWindow *application = [[UIApplication sharedApplication].delegate window];
    
    [application addSubview:hud];
    
    //设置对话框文字
    
    hud.labelText = @"正在查询中";
    
    [hud show:YES];
    
    [CSNetworkingManager sendGetRequestWithUrl:CSBrandSearchURL parameters:parameters success:^(id responseObject) {
        [hud hide:YES];
        if (CSInternetRequestSuccessful) {
            
            SendOutModel *model = [CSParseManager getSendOutPreciseModelArray:CSGetResult];
            if (self.listArray.count != 0) {
                [self.listArray removeAllObjects];
                
            }
            [self.listArray addObject:model];
            [self.listTableView reloadData];
            
            
        } else {
            CSShowWrongMessage
        }
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        
        CSInternetFailure
    }];
}
- (void)sendGetRequestForMoreFuzzySearchInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keyword"] = self.keywordTextField.text;
   
    parameters[@"type"] = @"0";
    
    self.page ++;
    
    parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    [CSNetworkingManager sendGetRequestWithUrl:CSBrandSearchURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            
            NSMutableArray *array = [CSParseManager getSendOutModelArray:CSGetResult];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
                [self.internetArray addObjectsFromArray:array];
                  [self.internetTableVIew reloadData];
            }
          
            
            
        } else {
             self.page --;
            CSShowWrongMessage
        }
        [self endRefresh];
    } failure:^(NSError *error) {
        self.page --;
        [self endRefresh];
        CSInternetFailure
    }];
}
- (void)sendGetRequestForFuzzySearch {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keyword"] = self.keywordTextField.text;

    parameters[@"type"] = @"0";
    
    self.page = 1;
    
     parameters[@"p"] =  [NSString stringWithFormat:@"%d",self.page];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    UIWindow *application = [[UIApplication sharedApplication].delegate window];
    
    [application addSubview:hud];
    
    //设置对话框文字
    
    hud.labelText = @"正在查询中";
    
    [hud show:YES];
    
    [CSNetworkingManager sendGetRequestWithUrl:CSBrandSearchURL parameters:parameters success:^(id responseObject) {
        [hud hide:YES];
        if (CSInternetRequestSuccessful) {
            
            self.internetArray = [CSParseManager getSendOutModelArray:CSGetResult];
            [self.internetTableVIew reloadData];
            self.searchEffectView.hidden = NO;
            
        } else {
            CSShowWrongMessage
        }
        [self endRefresh];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [self endRefresh];
       CSInternetFailure
    }];
}
- (void)endRefresh {
    [self.internetTableVIew.mj_footer endRefreshing];
    [self.internetTableVIew.mj_header endRefreshing];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return self.internetArray.count;
    }
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        SendOutDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SendOutDataTableViewCell) forIndexPath:indexPath];
        SendOutModel *model = self.internetArray[indexPath.row];
       
        cell.model = model;
        return cell;;
    }
    SendOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SendOutTableViewCell) forIndexPath:indexPath];
    SendOutModel *model = self.listArray[indexPath.row];
    cell.priceTextField.delegate = self;
    cell.model = model;
    return cell;;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        SendOutModel *model = self.internetArray[indexPath.row];
        if (!model.isCanUse) {
            CustomWrongMessage(@"商标状态无效");
            return;
        }
        model.chooseSelect = !model.chooseSelect;
        [self.internetTableVIew reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (IBAction)clickCancelSearchButton:(id)sender {
    self.searchEffectView.hidden = YES;
}

- (IBAction)clickSendOutButtonDone:(id)sender {
    NSMutableArray *array = @[].mutableCopy;
    for (SendOutModel *model in self.internetArray) {
        if (model.chooseSelect) {
            [array addObject:model];
        }
    
    }
    
    if (array.count == 0) {
        CustomWrongMessage(@"请选择要发布的商标");
        return;
    }
    
    
  
    if (self.listArray.count != 0) {
        [self.listArray removeAllObjects];
    }
    
    self.listArray = array;
    [self.listTableView reloadData];
    self.searchEffectView.hidden = YES;
    
  
}

- (IBAction)clickSureSendOutButtonDone:(id)sender {
    [self.view endEditing:YES];
    if (csCharacterIsBlank(CSGetToken)) {
        [CSUtility showLoginViewController];
        return;
    }
    
    if (csCharacterIsBlank(self.phoneTextField.text)) {
        CustomWrongMessage(@"请输入联系电话");
        return;
    }
    
    if (csCharacterIsBlank(self.QQTextField.text)) {
        
        CustomWrongMessage(@"请输入联系邮箱");
        return;
    }
    if (self.listArray.count == 0) {
        CustomWrongMessage(@"请选择要发布的商标");
        return;
    }
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"token"] = CSGetToken;
    for (int i = 0; i < self.listArray.count; i ++) {
        SendOutModel *model = self.listArray[i];
        parameters[[NSString stringWithFormat:@"goods_sn[%d]",i]] = model.regNo;

         parameters[[NSString stringWithFormat:@"cat_id[%d]",i]] = model.intCls;

        
        parameters[[NSString stringWithFormat:@"cost_price[%d]",i]] = model.willBuyTextField;
    }
    parameters[@"phone"] = self.phoneTextField.text;
    parameters[@"email"] = self.QQTextField.text;
    [CSNetworkingManager sendPostRequestWithUrl:CSSendOutBrandURL Parpmeters:parameters success:^(id responseObject) {
        
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"发布成功");
        } else {
            CSShowWrongMessage
        }
        
    } failure:^(NSError *error) {
       CSInternetFailure
    }];
}
#pragma -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *view = [textField superview];
    SendOutTableViewCell *cell = ( SendOutTableViewCell *)[[view superview] superview];
    NSIndexPath *indexPath = [self.listTableView indexPathForCell:cell];
    if (indexPath.row > self.listArray.count) {
        return;
    }
    SendOutModel *model = self.listArray[indexPath.row];
    model.willBuyTextField = textField.text;
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
