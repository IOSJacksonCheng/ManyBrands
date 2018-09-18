//
//  SendOutBrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SendOutBrandViewController.h"

#import "SendOutBrandTableViewCell.h"

#import "SendOutDataTableViewCell.h"
NSString * const PersonType = @"0";
NSString * const NumberType = @"1";
@interface SendOutBrandViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
- (IBAction)clickFunctionButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *QQTextField;
- (IBAction)clickSureSendOutButtonDone:(id)sender;

@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *internetArray;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (weak, nonatomic) IBOutlet UITableView *internetTableView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *searchEffectView;
- (IBAction)clickAllChooseButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *allChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *brandCountLabel;

- (IBAction)clickCancelSearchButton:(id)sender;
- (IBAction)clickSendOutBrandButtonDone:(id)sender;
@end

@implementation SendOutBrandViewController
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
    self.title = @"商标发布";
    [self configTableView];
    [self configSubViews];
}
- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SendOutBrandTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SendOutBrandTableViewCell)];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.listTableView.rowHeight = 147.5;
    [self.internetTableView registerNib:[UINib nibWithNibName:CSCellName(SendOutDataTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SendOutDataTableViewCell)];
    self.internetTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
   
    self.internetTableView.tag = 1;
    self.internetTableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForMoreFuzzySearchInfomation)];
    self.internetTableView.rowHeight = 55;
    self.internetTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)configSubViews {
    if ([self.type isEqualToString:PersonType]) {
        
        self.titleLabel.text = @"商标申请人";
        
    } else {
       self.titleLabel.text = @"商标注册号";
    }
    
    self.searchButton.layer.cornerRadius = 5;
    self.searchButton.layer.borderColor = csNavigationBarColor.CGColor;
    self.searchButton.layer.borderWidth = 1;
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
                [self.internetTableView reloadData];
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
            [self.internetTableView reloadData];
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
    [self.internetTableView.mj_footer endRefreshing];
    [self.internetTableView.mj_header endRefreshing];
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
    SendOutBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SendOutBrandTableViewCell) forIndexPath:indexPath];
    SendOutModel *model = self.listArray[indexPath.row];
    cell.moneyTextField.delegate = self;
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
        [self.internetTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
    SendOutModel *model = self.listArray[indexPath.row];
    model.willSendOut = !model.willSendOut;
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSInteger num = 0;
    for (SendOutModel *model in self.listArray) {
        if (model.willSendOut) {
            num ++;
        }
        
    }
    self.brandCountLabel.text = [NSString stringWithFormat:@"共%ld个商标",num];
    
}
#pragma -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *view = [textField superview];
    SendOutBrandTableViewCell *cell = ( SendOutBrandTableViewCell *)[view superview];
    NSIndexPath *indexPath = [self.listTableView indexPathForCell:cell];
    if (indexPath.row > self.listArray.count) {
        return;
    }
    SendOutModel *model = self.listArray[indexPath.row];
    model.willBuyTextField = textField.text;
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)clickAllChooseButtonDone:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (SendOutModel *model in self.listArray) {
        if (sender.selected) {
             model.willSendOut = YES;
        } else {
            model.willSendOut = NO;
        }
       
    }
    NSInteger count = 0;
    if (sender.selected) {
        count = self.listArray.count;
    }
    self.brandCountLabel.text = [NSString stringWithFormat:@"共%ld个商标",count];
    [self.listTableView reloadData];
}

- (IBAction)clickCancelSearchButton:(id)sender {
    self.searchEffectView.hidden = YES;
}

- (IBAction)clickSureSendOutButtonDone:(id)sender {
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

- (IBAction)clickSendOutBrandButtonDone:(id)sender {
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
- (IBAction)clickFunctionButtonDone:(UIButton *)sender {
      [self.view endEditing:YES];
    if ([self.type isEqualToString:PersonType]) {
        //1 person
       [self sendGetRequestForFuzzySearch];
    } else if ([self.type isEqualToString:NumberType]) {
        
        //2 search
        [self sendGetRequestForPreciseSearch];
       
    }
    
    
    
}
@end
