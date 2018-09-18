//
//  NewApplyPersonViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "NewApplyPersonViewController.h"
#import "NewApplyPersonButtonTableViewCell.h"
#import "NewApplyPersonImageViewTableViewCell.h"
#import "NewApplyPersonTextFieldTableViewCell.h"

#import "SelectPhotoManager.h"
#import "CZHAddressPickerView.h"
NSString * const China = @"中国大陆";
NSString * const TaiWanOfChina = @"中国台湾";
NSString * const HongKongOfChina = @"中国香港";
NSString * const MacaoOfChina = @"中国澳门";
@interface NewApplyPersonViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *companyArray;
@property (nonatomic, strong) NSMutableArray *companyHongKongArray;
@property (nonatomic, strong) NSMutableArray *personArray;
@property (nonatomic, strong) NSMutableArray *personHongKongArray;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *companyButton;

@property (weak, nonatomic) IBOutlet UIButton *personButton;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, assign) BOOL chooseCompany;

- (IBAction)clickSaveButtonDone:(id)sender;
@property (nonatomic, assign) BOOL companyApplyIsChina;
@property (nonatomic, assign) BOOL personApplyIsChina;

@property (nonatomic, strong) SelectPhotoManager *photoManager;
@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;
@property (nonatomic, strong) NewApplyPersonModel *backCard6Model;
@property (nonatomic, strong) NSString *recordCompanyArea;
@property (nonatomic, strong) NSString *recordPersonArea;
@end

@implementation NewApplyPersonViewController
- (NewApplyPersonModel *)backCard6Model {
    if (!_backCard6Model) {
        _backCard6Model = [NewApplyPersonModel new];
        
        _backCard6Model.title = @"证件反面照:";
        _backCard6Model.type = ImageViewCellType;
        _backCard6Model.remark = @"证件文件反面照或彩色扫描件(需签名)";
    }
    return _backCard6Model;
}
- (SelectPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[SelectPhotoManager alloc]init];
    }
    return _photoManager;
}
- (NSMutableArray *)personHongKongArray {
    if (!_personHongKongArray) {
        _personHongKongArray = @[].mutableCopy;
        
        NewApplyPersonModel *model = [NewApplyPersonModel new];
        model.title = @"申请人类型:";
        model.type = ButtonCellType;
        model.content = China;
        
        NewApplyPersonModel *model1 = [NewApplyPersonModel new];
        model1.title = @"申请人姓名:";
        model1.type = TextFieldCellType;
        
        NewApplyPersonModel *model2 = [NewApplyPersonModel new];
        model2.title = @"申请人姓名(外文):";
        model2.type = TextFieldCellType;
        
        NewApplyPersonModel *model3 = [NewApplyPersonModel new];
        model3.title = @"证件类型:";
        model3.type = ButtonCellType;
        model3.content = @"身份证";
        
        NewApplyPersonModel *model4 = [NewApplyPersonModel new];
        model4.title = @"证件号码:";
        model4.type = TextFieldCellType;
        
        NewApplyPersonModel *model5 = [NewApplyPersonModel new];
        model5.title = @"证件正面照:";
        model5.type = ImageViewCellType;
        model5.remark = @"证件文件正面照或彩色扫描件(需签名)";
        
        NewApplyPersonModel *model6 = [NewApplyPersonModel new];
        model6.title = @"证件反面照:";
        model6.type = ImageViewCellType;
        model6.remark = @"证件文件反面照或彩色扫描件(需签名)";
        
        NewApplyPersonModel *model7 = [NewApplyPersonModel new];
        model7.title = @"主体资格证明文件是否为中文:";
        model7.type = ButtonCellType;
        model7.content = @"点击选择";
        NewApplyPersonModel *model8 = [NewApplyPersonModel new];
        model8.title = @"主体资格证明文件:";
        model8.type = ImageViewCellType;
        model8.remark = @"请上传公司营业执照";
        
        
        NewApplyPersonModel *model9 = [NewApplyPersonModel new];
        model9.title = @"主体资格证明文件(英文):";
        model9.type = ImageViewCellType;
        model9.remark = @"请上传公司营业执照";
        
        NewApplyPersonModel *model10 = [NewApplyPersonModel new];
        model10.title = @"申请人地址:";
        model10.type = TextFieldCellType;
        
        NewApplyPersonModel *model11 = [NewApplyPersonModel new];
        model11.title = @"申请人地址(英文):";
        model11.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model12 = [NewApplyPersonModel new];
        model12.title = @"大陆联系人电话:";
        model12.type = TextFieldCellType;
        model12.placeHolder = @"商标状态更新会短信通知";
        
        NewApplyPersonModel *model13 = [NewApplyPersonModel new];
        model13.title = @"大陆联系人传真:";
        model13.type = TextFieldCellType;
        model13.placeHolder = @"联系人传真(含区号)";
        
        NewApplyPersonModel *model14 = [NewApplyPersonModel new];
        model14.title = @"大陆联系人邮编:";
        model14.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model15 = [NewApplyPersonModel new];
        model15.title = @"大陆联系人邮箱:";
        model15.type = TextFieldCellType;
        [_personHongKongArray addObject:model];
        
          [_personHongKongArray addObject:model1];
        
          [_personHongKongArray addObject:model2];
        
          [_personHongKongArray addObject:model3];
        [_personHongKongArray addObject:model4];
        
        [_personHongKongArray addObject:model5];
        
        [_personHongKongArray addObject:model6];
        [_personHongKongArray addObject:model7];
        
        [_personHongKongArray addObject:model8];
        
        [_personHongKongArray addObject:model9];
        [_personHongKongArray addObject:model10];
        
        [_personHongKongArray addObject:model11];
        
        [_personHongKongArray addObject:model12];
        
        [_personHongKongArray addObject:model13];
        
        [_personHongKongArray addObject:model14];
        [_personHongKongArray addObject:model15];
    }
    return _personHongKongArray;
}
- (NSMutableArray *)personArray {
    if (!_personArray) {
        _personArray = @[].mutableCopy;
        NewApplyPersonModel *model = [NewApplyPersonModel new];
        model.title = @"申请人类型:";
        model.type = ButtonCellType;
        model.content = China;
        
        NewApplyPersonModel *model1 = [NewApplyPersonModel new];
        model1.title = @"申请人姓名:";
        model1.type = TextFieldCellType;
        
        NewApplyPersonModel *model2 = [NewApplyPersonModel new];
        model2.title = @"证件类型:";
        model2.type = ButtonCellType;
        model2.content = @"身份证";
        
        NewApplyPersonModel *model3 = [NewApplyPersonModel new];
        model3.title = @"证件号码:";
        model3.type = TextFieldCellType;
        
        NewApplyPersonModel *model4 = [NewApplyPersonModel new];
        model4.title = @"证件正面照:";
        model4.type = ImageViewCellType;
        model4.remark = @"证件文件正面照或彩色扫描件(需签名)";
        
        NewApplyPersonModel *model5 = [NewApplyPersonModel new];
        model5.title = @"证件反面照:";
        model5.type = ImageViewCellType;
        model5.remark = @"证件文件反面照或彩色扫描件(需签名)";
        
        NewApplyPersonModel *model6 = [NewApplyPersonModel new];
        model6.title = @"主体资格证明文件:";
        model6.type = ImageViewCellType;
        model6.remark = @"请上传公司营业执照";
        
        NewApplyPersonModel *model7 = [NewApplyPersonModel new];
        model7.title = @"申请人行政区划:";
        model7.type = ButtonCellType;
        model7.content = @"选择地址";
        
        
        NewApplyPersonModel *model8 = [NewApplyPersonModel new];
        model8.title = @"营业执照地址:";
        model8.type = TextFieldCellType;
        
        
  

        NewApplyPersonModel *model10 = [NewApplyPersonModel new];
        model10.title = @"联系人:";
        model10.type = TextFieldCellType;
        
        NewApplyPersonModel *model11 = [NewApplyPersonModel new];
        model11.title = @"联系人电话:";
        model11.type = TextFieldCellType;
        model11.placeHolder = @"商标状态更新会短信通知";
        
        NewApplyPersonModel *model12 = [NewApplyPersonModel new];
        model12.title = @"联系人传真:";
        model12.type = TextFieldCellType;
        model12.placeHolder = @"联系人传真(含区号)";
        
        NewApplyPersonModel *model13 = [NewApplyPersonModel new];
        model13.title = @"联系人邮编:";
        model13.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model14 = [NewApplyPersonModel new];
        model14.title = @"联系人邮箱:";
        model14.type = TextFieldCellType;
        
        [_personArray addObject:model];
        [_personArray addObject:model1];
        [_personArray addObject:model2];
        [_personArray addObject:model3];
        [_personArray addObject:model4];
        [_personArray addObject:model5];
        [_personArray addObject:model6];
        [_personArray addObject:model7];
        [_personArray addObject:model8];
//        [_personArray addObject:model9];
        [_personArray addObject:model10];
        [_personArray addObject:model11];
        [_personArray addObject:model12];
        [_personArray addObject:model13];
        [_personArray addObject:model14];
    }
    return _personArray;
}

- (NSMutableArray *)companyHongKongArray {
    if (!_companyHongKongArray) {
        _companyHongKongArray = @[].mutableCopy;
        NewApplyPersonModel *model = [NewApplyPersonModel new];
        model.title = @"申请人类型:";
        model.type = ButtonCellType;
        model.content = China;
        
        NewApplyPersonModel *model1 = [NewApplyPersonModel new];
        model1.title = @"企业名称:";
        model1.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model11 = [NewApplyPersonModel new];
        model11.title = @"企业名称(外文):";
        model11.type = TextFieldCellType;
        
        NewApplyPersonModel *model4 = [NewApplyPersonModel new];
        model4.title = @"主体资格证明文件是否为中文:";
        model4.type = ButtonCellType;
        model4.content = @"点击选择";
        
        NewApplyPersonModel *model2 = [NewApplyPersonModel new];
        model2.title = @"主体资格证明文件:";
        model2.type = ImageViewCellType;
        model2.remark = @"请上传公司营业执照";
        
        
        NewApplyPersonModel *model3 = [NewApplyPersonModel new];
        model3.title = @"主体资格证明文件(英文):";
        model3.type = ImageViewCellType;
        model3.remark = @"请上传公司营业执照";
        
        NewApplyPersonModel *model5 = [NewApplyPersonModel new];
        model5.title = @"申请人地址:";
        model5.type = TextFieldCellType;
        
        NewApplyPersonModel *model6 = [NewApplyPersonModel new];
        model6.title = @"申请人地址(英文):";
        model6.type = TextFieldCellType;
        NewApplyPersonModel *model66 = [NewApplyPersonModel new];
        model66.title = @"大陆联系人:";
        model66.type = TextFieldCellType;
        
        NewApplyPersonModel *model7 = [NewApplyPersonModel new];
        model7.title = @"大陆联系人电话:";
        model7.type = TextFieldCellType;
        model7.placeHolder = @"商标状态更新会短信通知";
        
        NewApplyPersonModel *model8 = [NewApplyPersonModel new];
        model8.title = @"大陆联系人地址:";
        model8.type = TextFieldCellType;
//        model8.placeHolder = @"联系人传真(含区号)";
    
        NewApplyPersonModel *model9 = [NewApplyPersonModel new];
        model9.title = @"大陆联系人邮编:";
        model9.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model10 = [NewApplyPersonModel new];
        model10.title = @"大陆联系人邮箱:";
        model10.type = TextFieldCellType;
        
        [_companyHongKongArray addObject:model];
        [_companyHongKongArray addObject:model1];
        [_companyHongKongArray addObject:model11];
          [_companyHongKongArray addObject:model4];
        [_companyHongKongArray addObject:model2];
        [_companyHongKongArray addObject:model3];
      
        [_companyHongKongArray addObject:model5];
        [_companyHongKongArray addObject:model6];
        [_companyHongKongArray addObject:model66];
        [_companyHongKongArray addObject:model7];
        [_companyHongKongArray addObject:model8];
        [_companyHongKongArray addObject:model9];
        [_companyHongKongArray addObject:model10];
    }
    return _companyHongKongArray;
}
- (NSMutableArray *)companyArray {
    if (!_companyArray) {
        _companyArray = @[].mutableCopy;
        NewApplyPersonModel *model = [NewApplyPersonModel new];
        model.title = @"申请人类型:";
        model.type = ButtonCellType;
        model.content = China;
        
        NewApplyPersonModel *model1 = [NewApplyPersonModel new];
        model1.title = @"企业名称:";
        model1.type = TextFieldCellType;
        
        NewApplyPersonModel *model2 = [NewApplyPersonModel new];
        model2.title = @"主体资格证明文件:";
        model2.type = ImageViewCellType;
        
        NewApplyPersonModel *model3 = [NewApplyPersonModel new];
        model3.title = @"申请人行政区划:";
        model3.type = ButtonCellType;
        
        NewApplyPersonModel *model4 = [NewApplyPersonModel new];
        model4.title = @"营业执照地址:";
        model4.type = TextFieldCellType;
        
        NewApplyPersonModel *model5 = [NewApplyPersonModel new];
        model5.title = @"联系人:";
        model5.type = TextFieldCellType;
        
        NewApplyPersonModel *model6 = [NewApplyPersonModel new];
        model6.title = @"联系人电话:";
        model6.type = TextFieldCellType;
        model6.placeHolder = @"商标状态更新会短信通知";
        
        NewApplyPersonModel *model7 = [NewApplyPersonModel new];
        model7.title = @"联系人传真:";
        model7.type = TextFieldCellType;
        model7.placeHolder = @"联系人传真(含区号)";
        
        NewApplyPersonModel *model8 = [NewApplyPersonModel new];
        model8.title = @"联系人邮编:";
        model8.type = TextFieldCellType;
        
        
        NewApplyPersonModel *model9 = [NewApplyPersonModel new];
        model9.title = @"联系人邮箱:";
        model9.type = TextFieldCellType;
        
        [_companyArray addObject:model];
          [_companyArray addObject:model1];
          [_companyArray addObject:model2];
          [_companyArray addObject:model3];
          [_companyArray addObject:model4];
          [_companyArray addObject:model5];
          [_companyArray addObject:model6];
          [_companyArray addObject:model7];
          [_companyArray addObject:model8];
          [_companyArray addObject:model9];
        
    }
    return _companyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加申请人";
    [self configSubviews];
    [self clickCompanyButton];
}
- (void)configSubviews {
    self.recordCompanyArea = @"中国大陆";
     self.recordPersonArea = @"中国大陆";
    [self.personButton addTarget:self action:@selector(clickPersonButton) forControlEvents:UIControlEventTouchDown];
      [self.companyButton addTarget:self action:@selector(clickCompanyButton) forControlEvents:UIControlEventTouchDown];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(NewApplyPersonButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NewApplyPersonButtonTableViewCell)];
    
     [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(NewApplyPersonImageViewTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NewApplyPersonImageViewTableViewCell)];
    
     [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(NewApplyPersonTextFieldTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NewApplyPersonTextFieldTableViewCell)];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.personApplyIsChina = YES;
    self.companyApplyIsChina = YES;
    self.buttonView.layer.cornerRadius = 5;
    self.buttonView.layer.borderColor = csNavigationBarColor.CGColor;
    self.buttonView.layer.borderWidth = 1;
}
- (void)clickCompanyButton {
    [self.companyButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    [self.companyButton setBackgroundColor:csNavigationBarColor];
    [self.personButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    [self.personButton setBackgroundColor:csWhiteColor];
    self.chooseCompany = YES;
    [self.listTableView reloadData];
}
- (void)clickPersonButton {
    [self.personButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    [self.personButton setBackgroundColor:csNavigationBarColor];
    [self.companyButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    [self.companyButton setBackgroundColor:csWhiteColor];
    self.chooseCompany = NO;
    [self.listTableView reloadData];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.chooseCompany) {
        if (self.companyApplyIsChina) {
            return self.companyArray.count;
        }
        return self.companyHongKongArray.count;
    }
    if (self.personApplyIsChina) {
        return self.personArray.count;
    }
    return self.personHongKongArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewApplyPersonModel *model = [self getCurrentModel:indexPath];
    if (model.type == ButtonCellType) {
        if (indexPath.row == 0) {
            NewApplyPersonButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewApplyPersonButtonTableViewCell) forIndexPath:indexPath];
            if (self.chooseCompany) {
                model.content = self.recordCompanyArea;
            } else {
                model.content = self.recordPersonArea;
            }
           
            
            cell.model = model;
            return cell;
        }
        NewApplyPersonButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewApplyPersonButtonTableViewCell) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else if (model.type == TextFieldCellType) {
        NewApplyPersonTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewApplyPersonTextFieldTableViewCell) forIndexPath:indexPath];
        cell.model = model;
        cell.contentTextField.delegate = self;
        return cell;
    }
    
    NewApplyPersonImageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewApplyPersonImageViewTableViewCell) forIndexPath:indexPath];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewApplyPersonModel *model = [self getCurrentModel:indexPath];
    if (model.type == ButtonCellType) {
        if ([model.title isEqualToString:@"申请人类型:"]) {
            [self showApplyPersonTypeWithModel:model WithIndexPath:indexPath];
        } else if ([model.title isEqualToString:@"证件类型:"]) {
            [self showCardIdWithModel:model WithIndexPath:indexPath];
        } else if ([model.title isEqualToString:@"主体资格证明文件是否为中文:"]) {
            [self showIsChineseWithModel:model WithIndexPath:indexPath];
        } else if ([model.title isEqualToString:@"申请人行政区划:"]) {
             __weak typeof(self)weakSelf = self;            [CZHAddressPickerView areaPickerViewWithAreaBlock:^(NSString *province, NSString *city, NSString *area) {
                 model.content = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
                 self.province = province;
                 self.city = city;
                 self.area = area;
                 [weakSelf.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
             
            }];
        }
    } else if (model.type == ImageViewCellType) {
        
        
        [self.photoManager startSelectPhotoWithImageName:nil];
        __weak typeof(self)weakSelf = self;
        //选取照片成功
        self.photoManager.successHandle = ^(SelectPhotoManager *manager, UIImage *image, NSString *imageName) {
            

            [weakSelf uploadImageWithImageName:imageName WithImage:image WithModel:model WithIndexPath:indexPath];
        };

        
    }
   
}
- (void)uploadImageWithImageName:(NSString *)imageName WithImage:(UIImage *)currentImage WithModel:(NewApplyPersonModel *)model WithIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"images"];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:imageDocPath];
    if (!exist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *imagePath = [imageDocPath stringByAppendingPathComponent:imageName];
    
    
    [CSUtility saveImage:currentImage withName:imageName];
    [CSNetworkingManager sendPostForUploadImageWithUrl:CSUploadImageURL headerImageFilePath:imagePath fileName:imageName parpameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"上传图片成功");
            model.chooseImage = currentImage;
            model.content = [NSString stringWithFormat:@"%@",CSGetResult];
            [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
          
        } else {
            CustomWrongMessage(@"图片上传失败");
        }
    } failure:^(NSError *error) {
        CustomWrongMessage(@"图片上传失败");
    }];
}
- (void)showIsChineseWithModel:(NewApplyPersonModel *)model WithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *messageArray = @[@"是",@"否"];
    
    for (int i = 0; i < messageArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                model.content = messageArray[i];
               
                [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        }];
        
        [alert addAction:action];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
- (BOOL)containModel6 {
    BOOL have = NO;
    if (self.personApplyIsChina) {
        
        for (NewApplyPersonModel *deleteModel in self.personArray) {
            if ([deleteModel.title isEqualToString:@"证件反面照:"]) {
                have = YES;
                break;
            }
        }
    } else {
        for (NewApplyPersonModel *deleteModel in self.personHongKongArray) {
            if ([deleteModel.title isEqualToString:@"证件反面照:"]) {
                have = YES;
                break;
            }
        }
    }
    return have;
}
- (void)showCardIdWithModel:(NewApplyPersonModel *)model WithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *messageArray = @[@"身份证",@"护照",@"其它"];
    
    for (int i = 0; i < messageArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                model.content = messageArray[i];
                if (self.personApplyIsChina) {
                    if ([model.content isEqualToString:@"身份证"] && ![self containModel6]) {
                        [self.personArray insertObject:self.backCard6Model atIndex:5];
                    } else {
                        if ([self containModel6]) {
                            [self.personArray removeObjectAtIndex:5];
                        }
                    }
                } else {
                    if ([model.content isEqualToString:@"身份证"] && ![self containModel6]) {
                        [self.personHongKongArray insertObject:self.backCard6Model atIndex:6];
                    }else {
                        if ([self containModel6]) {
                            [self.personHongKongArray removeObjectAtIndex:6];
                        }
                    }
                }
                
                [self.listTableView reloadData];
            });
            
        }];
        
        [alert addAction:action];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
- (void)showApplyPersonTypeWithModel:(NewApplyPersonModel *)model WithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *messageArray = @[China,TaiWanOfChina, HongKongOfChina, MacaoOfChina];
    for (int i = 0; i < messageArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                model.content = messageArray[i];
                if (self.chooseCompany) {
                     self.recordCompanyArea = messageArray[i];
                    if ([model.content isEqualToString:China]) {
                        self.companyApplyIsChina = YES;
                    } else {
                        self.companyApplyIsChina = NO;
                    }
                } else {
                     self.recordPersonArea = messageArray[i];
                    if ([model.content isEqualToString:China]) {
                        self.personApplyIsChina = YES;
                    } else {
                        self.personApplyIsChina = NO;
                    }
                }
               
                [self.listTableView reloadData];
            });
            
        }];
        
        [alert addAction:action];
        
    }
   
    
    
   
    
    
   
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewApplyPersonModel *model = [self getCurrentModel:indexPath];
  if (model.type == ImageViewCellType) {
      
        return 100;
  } else if ([model.title isEqualToString:@"主体资格证明文件是否为中文:"]) {
      return 80;
  }
    
  
    return 50;
}
- (NewApplyPersonModel *)getCurrentModel:(NSIndexPath *)indexPath {
    NewApplyPersonModel *model = [NewApplyPersonModel new];
    if (self.chooseCompany) {
        if (self.companyApplyIsChina) {
            model = self.companyArray[indexPath.row];
        } else {
            model = self.companyHongKongArray[indexPath.row];
        }
        
    } else {
        if (self.personApplyIsChina) {
            
            model = self.personArray[indexPath.row];
        } else {
            model = self.personHongKongArray[indexPath.row];
        }
        
    }
    return model;
}
#pragma mark -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *view = [textField superview];
    NewApplyPersonTextFieldTableViewCell *cell = (NewApplyPersonTextFieldTableViewCell *)[view superview];
    NSIndexPath *indexPath = [self.listTableView indexPathForCell:cell];
      NewApplyPersonModel *model = [self getCurrentModel:indexPath];
    model.content = textField.text;
    [self.listTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (IBAction)clickSaveButtonDone:(id)sender {
    NSMutableArray *resultArray = @[].mutableCopy;
    if (self.chooseCompany) {
        if (self.companyApplyIsChina) {
            resultArray = self.companyArray;
        } else {
            resultArray = self.companyArray;
        }
        
    } else {
        if (self.personApplyIsChina) {
            
            resultArray = self.personArray;
        } else {
            resultArray = self.personHongKongArray;
        }
        
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NewApplyPersonModel *newModel in resultArray) {
        if ([newModel.title isEqualToString:@"企业名称:"] || [newModel.title isEqualToString:@"申请人姓名:"]) {
             parameters[@"name"] = newModel.content;
        } else if ([newModel.title isEqualToString:@"企业名称(外文):"]) {
            parameters[@"nameen"] = newModel.content;
        }else if ([newModel.title isEqualToString:@"主体资格证明文件是否为中文:"]) {
            if ([newModel.content isEqualToString:@"是"]) {
                parameters[@"nameen"] = @"1";
            }else {
                parameters[@"nameen"] = @"0";
            }
            
        }else if ([newModel.title isEqualToString:@"申请人类型:"]) {
            if ([newModel.content isEqualToString:China]) {
                parameters[@"nationality"] = @"1";
            }else if ([newModel.content isEqualToString:TaiWanOfChina])  {
                parameters[@"nationality"] = @"3";
            }else if ([newModel.content isEqualToString:HongKongOfChina])  {
                parameters[@"nationality"] = @"4";
            }else if ([newModel.content isEqualToString:MacaoOfChina])  {
                parameters[@"nationality"] = @"5";
            }
            
        }else if ([newModel.title isEqualToString:@"证件类型:"]) {
            parameters[@"cardtype"] = newModel.content;
            
        }else if ([newModel.title isEqualToString:@"主体资格证明文件:"]) {
            parameters[@"cardtype"] = newModel.content;
            
        }else if ([newModel.title isEqualToString:@"主体资格证明文件(英文):"]) {
            parameters[@"ztfileen"] = newModel.content;
            
        }else if ([newModel.title isEqualToString:@"证件号码:"]) {
            parameters[@"cardId"] = newModel.content;
            
        } else if ([newModel.title isEqualToString:@"证件正面照:"]) {
            parameters[@"cardfile"] = newModel.content;
            
        }else if ([newModel.title isEqualToString:@"证件反面照:"]) {
            parameters[@"cardfile2"] = newModel.content;
            
        }else if ([newModel.title isEqualToString:@"申请人行政区划:"] && !csCharacterIsBlank(self.province)) {
            parameters[@"areaProv"] = self.province;
             parameters[@"areaCity"] = self.city;
             parameters[@"areaDistrict"] = self.area;
        }else if ([newModel.title isEqualToString:@"大陆联系人地址:"] || [newModel.title isEqualToString:@"营业执照地址:"]) {
            parameters[@"address"] = newModel.content;
            
            
        }else if ([newModel.title isEqualToString:@"申请人地址(英文):"]) {
            parameters[@"addressen"] = newModel.content;
            
            
        }else if ([newModel.title isEqualToString:@"大陆联系人:"] || [newModel.title isEqualToString:@"联系人:"]) {
            parameters[@"receive_name"] = newModel.content;
            
            
        }else if ([newModel.title isEqualToString:@"大陆联系人电话:"] || [newModel.title isEqualToString:@"联系人电话:"]) {
            parameters[@"receive_phone"] = newModel.content;
            
            
        }else if ([newModel.title isEqualToString:@"联系人传真:"] || [newModel.title isEqualToString:@"大陆联系人传真:"]) {
            parameters[@"receive_fax"] = newModel.content;
            
            
        }else if ([newModel.title isEqualToString:@"联系人邮编:"] || [newModel.title isEqualToString:@"大陆联系人邮编:"]) {
            parameters[@"receive_postcode"] = newModel.content;
        
        }else if ([newModel.title isEqualToString:@"联系人邮箱:"] || [newModel.title isEqualToString:@"大陆联系人邮箱:"]) {
            parameters[@"Email"] = newModel.content;
            
        }
    }
  
    
    [CSNetworkingManager sendPostRequestWithUrl:CSAddNewApplyPersonURL Parpmeters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"保存成功")
        } else {
            CSShowWrongMessage
        }
    } failure:^(NSError *error) {
        CSInternetFailure
    }];
    
}
@end
