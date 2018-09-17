//
//  RegisterFirstStepViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterFirstStepViewController.h"
#import "SelectPhotoManager.h"


#import "RegisterSecondStepViewController.h"

#import "RegisterFirstStepImageTableViewCell.h"
#import "RegisterFirstStepExplainTableViewCell.h"
#import "RegisterFirstStepButtonTableViewCell.h"
#import "RegisterFirstStepApplyPersonTableViewCell.h"
#import "RegisterFirstStepNameTableViewCell.h"

@interface RegisterFirstStepViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate>
- (IBAction)clickNextStepButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *firstStepTableView;
@property (nonatomic, strong) SelectPhotoManager *photoManager;
//代理委托书
@property (nonatomic, strong) UIImage *recordDelegateImage;
@property (nonatomic, strong) NSString *recordDelegateImageURL;
//黑白图样:
@property (nonatomic, strong) UIImage *recordBlackSampleImage;
@property (nonatomic, strong) NSString *recordBlackImageURL;
@property (nonatomic, strong) UILabel *recordExplainLabel;
@property (nonatomic, strong) NSString *recordExplainString;
@property (nonatomic, assign) BOOL clickChooseButton;
@property (nonatomic, assign) BOOL chooseBlackButton;

@property (nonatomic, strong) NSString *recordApplyPerson;
@property (nonatomic, strong) NSString *recordBrandName;
@end

@implementation RegisterFirstStepViewController
- (SelectPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[SelectPhotoManager alloc]init];
    }
    return _photoManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册商标";
    self.firstStepTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.firstStepTableView registerNib:[UINib nibWithNibName:CSCellName(RegisterFirstStepImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RegisterFirstStepImageTableViewCell)];
    [self.firstStepTableView registerNib:[UINib nibWithNibName:CSCellName(RegisterFirstStepExplainTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RegisterFirstStepExplainTableViewCell)];
    [self.firstStepTableView registerNib:[UINib nibWithNibName:CSCellName(RegisterFirstStepButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RegisterFirstStepButtonTableViewCell)];
    
    


    [self.firstStepTableView registerNib:[UINib nibWithNibName:CSCellName(RegisterFirstStepApplyPersonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RegisterFirstStepApplyPersonTableViewCell)];
    [self.firstStepTableView registerNib:[UINib nibWithNibName:CSCellName(RegisterFirstStepNameTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RegisterFirstStepNameTableViewCell)];
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RegisterFirstStepNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepNameTableViewCell) forIndexPath:indexPath];
       
        if (csCharacterIsBlank(self.recordApplyPerson)) {
            cell.applyPersonLabel.text = @"请点击选择";
        } else {
            cell.applyPersonLabel.text = self.recordApplyPerson;
        }
        return cell;
      
    } else if (indexPath.row == 1) {
        RegisterFirstStepApplyPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepApplyPersonTableViewCell) forIndexPath:indexPath];
        
        cell.brandNameTextField.text = self.recordBrandName;
        cell.brandNameTextField.delegate = self;
        return cell;
    }else if (indexPath.row == 2) {
        RegisterFirstStepImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepImageTableViewCell) forIndexPath:indexPath];
        if (self.recordDelegateImage) {
            cell.titleImageView.image = self.recordDelegateImage;
        }
        cell.titleLabel.text = @"代理委托书:";
        return cell;
    } else if (indexPath.row == 3) {
        
         RegisterFirstStepExplainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepExplainTableViewCell) forIndexPath:indexPath];
        if (csCharacterIsBlank(self.recordExplainString)) {
            cell.explainLabel.hidden = NO;
            
        } else {
            cell.explainLabel.hidden = YES;
        }
        self.recordExplainLabel = cell.explainLabel;
        cell.explainTextView.delegate = self;
        cell.explainTextView.text = self.recordExplainString;
        return cell;
    }else if (indexPath.row == 4) {
        
        RegisterFirstStepButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepButtonTableViewCell) forIndexPath:indexPath];
        if (self.clickChooseButton) {
            if (self.chooseBlackButton) {
                cell.blackButton.selected = YES;
                cell.colorButton.selected = NO;
            } else {
                cell.blackButton.selected = NO;
                cell.colorButton.selected = YES;
            }
        } else {
            cell.colorButton.selected = NO;
            cell.blackButton.selected = NO;
        }
        [cell.blackButton addTarget:self action:@selector(clickBlackButtonDone) forControlEvents:UIControlEventTouchDown];
        [cell.colorButton addTarget:self action:@selector(clickColorButtonDone) forControlEvents:UIControlEventTouchDown];
        return cell;
    }
    
        
        RegisterFirstStepImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RegisterFirstStepImageTableViewCell) forIndexPath:indexPath];
        if (self.recordBlackSampleImage) {
            cell.titleImageView.image = self.recordBlackSampleImage;
        }
        cell.titleLabel.text = @"黑白图样:";
        return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        if (self.recordDelegateImage) {
            return 150;
        }
        return 100;
    } else if (indexPath.row == 3) {
        return 100;
    } else if (indexPath.row == 5) {
        if (self.recordBlackSampleImage) {
            return 150;
        }
        return 100;
    }
    return 50;
}
- (void)clickBlackButtonDone {
    self.clickChooseButton = YES;
    self.chooseBlackButton = YES;
    [self.firstStepTableView reloadData];
}
- (void)clickColorButtonDone {
    self.clickChooseButton = YES;
    self.chooseBlackButton = NO;
    [self.firstStepTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
    //代理委托书
         [self selectDelegatePhoto];
    } else if (indexPath.row == 5) {
        //黑白图样
        [self selectBlackWhitePhoto];
    }
   
}
- (void)selectBlackWhitePhoto {
    [self.photoManager startSelectPhotoWithImageName:nil];
    __weak typeof(self)weakSelf = self;
    //选取照片成功
    self.photoManager.successHandle = ^(SelectPhotoManager *manager, UIImage *image, NSString *imageName) {
         weakSelf.recordBlackSampleImage = image;
        [weakSelf uploadImageWithImageName:imageName WithImage:image WithChooseBlackImage:YES];
    };

}
- (void)uploadImageWithImageName:(NSString *)imageName WithImage:(UIImage *)currentImage WithChooseBlackImage:(BOOL)isChooseBlackImage{
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
    
//    parameters[@"img"] = imagePath;
    [CSUtility saveImage:currentImage withName:imageName];
    [CSNetworkingManager sendPostForUploadImageWithUrl:CSUploadImageURL headerImageFilePath:imagePath fileName:imageName parpameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"上传图片成功");
            if (isChooseBlackImage) {
                self.recordBlackImageURL = [NSString stringWithFormat:@"%@",CSGetResult];;
            } else {
                self.recordDelegateImageURL =  [NSString stringWithFormat:@"%@",CSGetResult];
            }
            [self.firstStepTableView reloadData];
        } else {
             CustomWrongMessage(@"图片上传失败");
        }
    } failure:^(NSError *error) {
         CustomWrongMessage(@"图片上传失败");
    }];
}
- (void)selectDelegatePhoto {
   
    [self.photoManager startSelectPhotoWithImageName:nil];
    __weak typeof(self)weakSelf = self;
    //选取照片成功
    //选取照片成功
    self.photoManager.successHandle = ^(SelectPhotoManager *manager, UIImage *image, NSString *imageName) {
        weakSelf.recordDelegateImage = image;
        [weakSelf uploadImageWithImageName:imageName WithImage:image WithChooseBlackImage:NO];
    };
    
}
#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.recordExplainLabel.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.recordExplainString = textView.text;
    [self.firstStepTableView reloadData];
}
#pragma mark -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.recordBrandName = textField.text;
     [self.firstStepTableView reloadData];
}
- (IBAction)clickNextStepButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.recordApplyPerson) || csCharacterIsBlank(self.recordBrandName) || csCharacterIsBlank(self.recordDelegateImageURL) || csCharacterIsBlank(self.recordBlackImageURL) || !self.clickChooseButton) {
     CustomWrongMessage(@"请填写完整信息")
        return;
    }
    
    RegisterSecondStepViewController *new = [RegisterSecondStepViewController new];
    [self.navigationController pushViewController:new animated:YES];
}
@end
